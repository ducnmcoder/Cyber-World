/**
 * Cyber World AI Chatbot - Self-contained Widget
 * Auto-injects HTML into the page on load
 */
(function () {
    'use strict';

    // Prevent duplicate initialization
    if (document.getElementById('cyberChatbotToggle')) return;

    // ========================================
    // Inject HTML
    // ========================================
    const chatbotHTML = `
        <!-- Chatbot Toggle Button -->
        <button id="cyberChatbotToggle" class="chatbot-toggle-btn" title="Cyber World AI Assistant">
            <span class="chatbot-icon">🤖</span>
            <span class="chatbot-badge"></span>
        </button>

        <!-- Chatbot Window -->
        <div id="cyberChatbotWindow" class="chatbot-window">
            <!-- Header -->
            <div class="chatbot-header">
                <div class="chatbot-header-avatar">🤖</div>
                <div class="chatbot-header-info">
                    <div class="chatbot-header-title">Cyber World Assistant</div>
                    <div class="chatbot-header-status">Online — Ready to help</div>
                </div>
                <button id="cyberChatbotClose" class="chatbot-close-btn" title="Close">
                    <i class="fa-solid fa-xmark"></i>
                </button>
            </div>

            <!-- Messages -->
            <div id="cyberChatbotMessages" class="chatbot-messages"></div>

            <!-- Quick Suggestions -->
            <div id="cyberChatbotSuggestions" class="chatbot-suggestions">
                <button class="chatbot-suggestion-btn" data-msg="Laptops under 15 million VND">💰 Under 15M</button>
                <button class="chatbot-suggestion-btn" data-msg="Best gaming laptops">🎮 Gaming Laptops</button>
                <button class="chatbot-suggestion-btn" data-msg="Laptops for students">🎓 For Students</button>
                <button class="chatbot-suggestion-btn" data-msg="What Dell laptops do you have?">💻 Dell Laptops</button>
            </div>

            <!-- Input Area -->
            <div class="chatbot-input-area">
                <input type="text" id="cyberChatbotInput" class="chatbot-input" 
                       placeholder="Ask about our laptops..." 
                       autocomplete="off" />
                <button id="cyberChatbotSend" class="chatbot-send-btn" title="Send">
                    <i class="fa-solid fa-paper-plane"></i>
                </button>
            </div>
        </div>
    `;

    // Inject into body
    const container = document.createElement('div');
    container.innerHTML = chatbotHTML;
    while (container.firstChild) {
        document.body.appendChild(container.firstChild);
    }

    // ========================================
    // Get DOM elements
    // ========================================
    const toggleBtn = document.getElementById('cyberChatbotToggle');
    const chatWindow = document.getElementById('cyberChatbotWindow');
    const closeBtn = document.getElementById('cyberChatbotClose');
    const messagesContainer = document.getElementById('cyberChatbotMessages');
    const inputField = document.getElementById('cyberChatbotInput');
    const sendBtn = document.getElementById('cyberChatbotSend');
    const suggestionsContainer = document.getElementById('cyberChatbotSuggestions');

    let isOpen = false;
    let isFirstOpen = true;
    let isProcessing = false;

    // ========================================
    // CSRF Token helper
    // ========================================
    function getCsrfToken() {
        const csrfMeta = document.querySelector('meta[name="_csrf"]');
        if (csrfMeta) return csrfMeta.getAttribute('content');

        const csrfInput = document.querySelector('input[name="_csrf"]');
        if (csrfInput) return csrfInput.value;

        // Try to get from cookie
        const cookies = document.cookie.split(';');
        for (let cookie of cookies) {
            const [name, value] = cookie.trim().split('=');
            if (name === 'XSRF-TOKEN') return decodeURIComponent(value);
        }

        return null;
    }

    function getCsrfHeaderName() {
        const csrfHeaderMeta = document.querySelector('meta[name="_csrf_header"]');
        if (csrfHeaderMeta) return csrfHeaderMeta.getAttribute('content');
        return 'X-CSRF-TOKEN';
    }

    // ========================================
    // Toggle chat window
    // ========================================
    function toggleChat() {
        isOpen = !isOpen;
        chatWindow.classList.toggle('open', isOpen);
        toggleBtn.classList.toggle('active', isOpen);

        // Hide badge when opened
        const badge = toggleBtn.querySelector('.chatbot-badge');
        if (badge && isOpen) {
            badge.style.display = 'none';
        }

        if (isOpen) {
            if (isFirstOpen) {
                isFirstOpen = false;
                showWelcomeMessage();
            }
            setTimeout(() => inputField.focus(), 350);
        }
    }

    toggleBtn.addEventListener('click', toggleChat);
    closeBtn.addEventListener('click', toggleChat);

    // ========================================
    // Welcome message
    // ========================================
    function showWelcomeMessage() {
        addBotMessage('Hello! 👋 I\'m the AI assistant of **Cyber World**.\n\nI can help you find laptops by price, brand, specs, or purpose.\n\nFeel free to ask me anything about our laptop products! 😊');
    }

    // ========================================
    // Add messages
    // ========================================
    function addBotMessage(text) {
        const wrapper = document.createElement('div');
        wrapper.style.display = 'flex';
        wrapper.style.flexDirection = 'column';
        wrapper.style.alignItems = 'flex-start';

        const label = document.createElement('div');
        label.className = 'chatbot-msg-label';
        label.textContent = '🤖 Cyber Assistant';

        const bubble = document.createElement('div');
        bubble.className = 'chatbot-message bot';
        bubble.innerHTML = formatMessage(text);

        wrapper.appendChild(label);
        wrapper.appendChild(bubble);
        messagesContainer.appendChild(wrapper);
        scrollToBottom();
    }

    function addUserMessage(text) {
        const wrapper = document.createElement('div');
        wrapper.style.display = 'flex';
        wrapper.style.flexDirection = 'column';
        wrapper.style.alignItems = 'flex-end';

        const bubble = document.createElement('div');
        bubble.className = 'chatbot-message user';
        bubble.textContent = text;

        wrapper.appendChild(bubble);
        messagesContainer.appendChild(wrapper);
        scrollToBottom();
    }

    // ========================================
    // Format bot message (basic markdown)
    // ========================================
    function formatMessage(text) {
        // Bold: **text**
        text = text.replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>');
        // Italic: *text*
        text = text.replace(/(?<!\*)\*(?!\*)(.*?)(?<!\*)\*(?!\*)/g, '<em>$1</em>');
        // Links: [text](url)
        text = text.replace(/\[(.*?)\]\((.*?)\)/g, '<a href="$2" style="color: #cd1818; text-decoration: underline; font-weight: 600;">$1</a>');
        // Line breaks
        text = text.replace(/\n/g, '<br>');
        // Bullet points: - text
        text = text.replace(/^- (.+)/gm, '• $1');
        return text;
    }

    // ========================================
    // Typing indicator
    // ========================================
    function showTyping() {
        let typingEl = document.getElementById('cyberChatbotTyping');
        if (!typingEl) {
            typingEl = document.createElement('div');
            typingEl.id = 'cyberChatbotTyping';
            typingEl.className = 'chatbot-typing';
            typingEl.innerHTML = `
                <span class="chatbot-typing-dot"></span>
                <span class="chatbot-typing-dot"></span>
                <span class="chatbot-typing-dot"></span>
            `;
        }
        // Move typing element to the bottom every time
        messagesContainer.appendChild(typingEl);
        typingEl.classList.add('show');
        scrollToBottom();
    }

    function hideTyping() {
        const typingEl = document.getElementById('cyberChatbotTyping');
        if (typingEl) {
            typingEl.classList.remove('show');
        }
    }

    // ========================================
    // Scroll to bottom
    // ========================================
    function scrollToBottom() {
        setTimeout(() => {
            messagesContainer.scrollTop = messagesContainer.scrollHeight;
        }, 50);
    }

    // ========================================
    // Send message
    // ========================================
    async function sendMessage(text) {
        if (!text || text.trim() === '' || isProcessing) return;

        const message = text.trim();
        isProcessing = true;
        sendBtn.disabled = true;

        // Add user message
        addUserMessage(message);
        inputField.value = '';

        // Hide suggestions after first message
        if (suggestionsContainer) {
            suggestionsContainer.style.display = 'none';
        }

        // Show typing
        showTyping();

        try {
            const csrfToken = getCsrfToken();
            const csrfHeaderName = getCsrfHeaderName();

            const headers = {
                'Content-Type': 'application/json'
            };

            if (csrfToken) {
                headers[csrfHeaderName] = csrfToken;
            }

            const response = await fetch('/api/chatbot', {
                method: 'POST',
                headers: headers,
                body: JSON.stringify({ message: message })
            });

            hideTyping();

            if (response.ok) {
                const data = await response.json();
                addBotMessage(data.reply || 'Sorry, I don\'t have an answer right now.');
            } else {
                addBotMessage('Sorry, an error occurred. Please try again later. 😔');
            }
        } catch (error) {
            hideTyping();
            console.error('Chatbot error:', error);
            addBotMessage('Sorry, unable to connect to the server. Please try again later. 😔');
        } finally {
            isProcessing = false;
            sendBtn.disabled = false;
            inputField.focus();
        }
    }

    // ========================================
    // Event listeners
    // ========================================
    sendBtn.addEventListener('click', () => {
        sendMessage(inputField.value);
    });

    inputField.addEventListener('keydown', (e) => {
        if (e.key === 'Enter' && !e.shiftKey) {
            e.preventDefault();
            sendMessage(inputField.value);
        }
    });

    // Quick suggestion buttons
    suggestionsContainer.addEventListener('click', (e) => {
        const btn = e.target.closest('.chatbot-suggestion-btn');
        if (btn) {
            const msg = btn.getAttribute('data-msg');
            sendMessage(msg);
        }
    });

    // Close on Escape
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape' && isOpen) {
            toggleChat();
        }
    });

})();
