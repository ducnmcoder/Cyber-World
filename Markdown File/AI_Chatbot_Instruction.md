# AI Chatbot System Instructions

# Configuration and Deployment Guide

Follow these steps to configure, obtain API credentials, and deploy this AI chatbot to any website.

## Step 1: Obtain an API Key
To power the chatbot, you will need an API key from a supported AI provider (e.g., OpenAI, Google Gemini, or Anthropic).
1. Navigate to your chosen AI provider's developer console (e.g., [Google AI Studio](https://aistudio.google.com/) or [OpenAI Platform](https://platform.openai.com/)).
2. Create an account or sign in.
3. Locate the **API Keys** section in the dashboard.
4. Click **Create new API key** (or equivalent) and give it a recognizable name (e.g., "Project Web Chatbot").
5. Copy the generated API key immediately and store it securely. Do not commit this key directly to public repositories.

## Step 2: Configure the Chatbot
You will need to pass the system instructions (defined above) and your API key to the chatbot instance.
1. Create a configuration file (e.g., `config.json` or a `.env` file) in your project root.
2. Add your API key as an environment variable:
   ```env
   VITE_AI_API_KEY=your_api_key_here
   ```
3. Load the contents of this `AI_Chatbot_Instruction.md` file into your application to serve as the "System Prompt" when initializing the AI client.
4. Configure the model parameters:
   - **Temperature**: Set to `0.2` or `0.3` to keep responses focused and factual.
   - **Max Tokens**: Set a reasonable limit (e.g., `500`) to keep responses concise and minimize free-tier costs.

## Step 3: Deploy to Any Website
You can embed the chatbot into any HTML website using a simple script injection or an iframe.

### Option A: Using a Web Component / Script Tag (Recommended)
If your chatbot is bundled as a web component, include it directly in your HTML before the closing `</body>` tag:
```html
<!-- Load the chatbot script -->
<script src="https://your-domain.com/chatbot-bundle.js" defer></script>

<!-- Initialize the chatbot -->
<project-chatbot 
    api-url="https://your-api-endpoint.com/chat" 
    theme="light" 
    title="Project Assistant">
</project-chatbot>
```
*(Note: Ensure your backend endpoint securely handles the API key, rather than exposing the API key directly in the frontend HTML.)*

### Option B: Using an Iframe
If the chatbot is hosted on a separate page, embed it via an iframe:
```html
<iframe 
    src="https://your-domain.com/chatbot-ui" 
    width="350" 
    height="500" 
    style="border: none; position: fixed; bottom: 20px; right: 20px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
</iframe>
```

## Step 4: Testing & Verification
1. Once deployed, open your website in a browser.
2. Ask a project-related question to verify it responds correctly.
3. Ask an unrelated question (e.g., "What is the capital of France?") to ensure the fallback response triggers as configured in the system instructions.
