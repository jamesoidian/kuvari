const { onCall, HttpsError } = require("firebase-functions/v2/https");
const { defineSecret } = require("firebase-functions/params");
const axios = require("axios");

const openSymbolsSecret = defineSecret("OPENSYMBOLS_SECRET");

let cachedToken = null;
let tokenExpiration = null;

async function getAccessToken() {
    const secret = openSymbolsSecret.value();
    if (!secret) {
        throw new HttpsError("failed-precondition", "OpenSymbols secret not set.");
    }

    // Check if token is valid (with 5 minute buffer)
    if (cachedToken && tokenExpiration && Date.now() < tokenExpiration - 5 * 60 * 1000) {
        return cachedToken;
    }

    try {
        const response = await axios.post("https://www.opensymbols.org/api/v2/token", {
            secret: secret,
        });

        if (response.data && response.data.access_token) {
            cachedToken = response.data.access_token;
            // expires_in is in seconds
            const expiresIn = response.data.expires_in || 3600;
            tokenExpiration = Date.now() + expiresIn * 1000;
            return cachedToken;
        } else {
            throw new Error("Invalid response from token endpoint");
        }
    } catch (error) {
        console.error("Error fetching token:", error);
        // Log detailed error if available
        if (error.response) {
            console.error("Response data:", error.response.data);
            console.error("Response status:", error.response.status);
        }
        throw new HttpsError("internal", "Failed to fetch OpenSymbols token.");
    }
}

exports.searchOpenSymbols = onCall({ secrets: [openSymbolsSecret] }, async (request) => {
    const query = request.data.query;
    if (!query) {
        throw new HttpsError("invalid-argument", "The function must be called with a 'query' argument.");
    }

    try {
        const token = await getAccessToken();
        const response = await axios.get("https://www.opensymbols.org/api/v2/symbols", {
            params: {
                q: query,
                access_token: token,
            },
        });

        // OpenSymbols API v2 search returns a list of objects.
        // Example item:
        // {
        //   "id": 123,
        //   "name": "cat",
        //   "image_url": "...",
        //   "repo_key": "...",
        //   ...
        // }
        const results = response.data;

        if (!Array.isArray(results)) {
            console.error("Unexpected response format:", results);
            return [];
        }

        return results.map(item => ({
            url: item.image_url,
            thumb: item.image_url, // OpenSymbols might not provide a separate thumbnail
            name: item.name,
            author: item.repo_key + " / " + item.license,
            uid: item.id ? item.id : null
        }));

    } catch (error) {
        console.error("Search error:", error);
        if (error.response) {
            console.error("Response data:", error.response.data);
        }
        throw new HttpsError("internal", "Failed to search OpenSymbols.");
    }
});
