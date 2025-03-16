 # AnyStatus (By Raz)
###### AnyStatus is a simple and customizable Discord Rich Presence (RPC) tool built using Delphi (RAD Studio). It allows users to set their Discord status to various activities such as Playing, Watching, Listening, or Streaming, with a custom topic. The tool is designed to be lightweight and easy to use, providing a seamless way to manage your Discord presence.

<p align="center"> <img src="https://i.ibb.co/21TsmBk0/Screenshot-2025-03-15-230040.png" align="center" style="width: 600px;max-height: 100%;hieght: auto;"/> </p>

## How It Works
1. **Setting Up**
   - The user enters their Discord token in the `Token` field. The token can be hidden or shown using the "Show/Hide Token" button.
   - The user sets a custom topic (e.g., a game name, movie, or song) in the `Topic` field.

2. **Choosing an Activity**
   - The user selects an activity type from the following options:
     - **Playing**: Sets the status to "Playing [Topic]".
     - **Watching**: Sets the status to "Watching [Topic]".
     - **Listening**: Sets the status to "Listening to [Topic]".
     - **Streaming**: Sets the status to "Streaming [Topic]".

3. **Saving Configuration**
   - The tool automatically saves the configuration (token, topic, and status) in a `cfg.json` file. This allows the settings to persist between sessions.

4. **Running the Rich Presence**
   - When an activity is selected, the tool generates a Python script (`res.py`) that uses the `discord.py` library to update the Discord status.
   - The Python script is executed in the background, and the selected activity is displayed on Discord.

## Features
- **Customizable Status**: Set your Discord status to Playing, Watching, Listening, or Streaming with a custom topic.
- **Token Management**: Securely enter and hide your Discord token.
- **Configuration Persistence**: Save your token, topic, and status in a `cfg.json` file for future use.
- **Lightweight**: Built using Delphi, the tool is lightweight and efficient.
- **Open Source**: The code is available on GitHub for customization and improvement.

## Limitations
- **Discord Token Required**: You need to provide your Discord token to use the tool. Be cautious when sharing your token, as it grants access to your account.
- **Self-Bot Usage**: The tool uses a self-bot, which is against Discord's Terms of Service. Use it at your own risk.
- **No Advanced Features**: The tool is designed for basic Rich Presence customization and does not support advanced features like custom images or buttons.
- **Delphi4Python wont allow loops**: Delphi4Python will freeze the GUI until python code finishes and discord RPC is a python script that wont end unless you close it meaning that the python freezes the GUI as they run in the same thread.

## How to Use
1. **Enter Your Token**:
   - Click the "Show Token" button to reveal the token field.
   - Enter your Discord token in the `Token` field.

2. **Set a Topic**:
   - Enter a custom topic in the `Topic` field (e.g., a game name, movie, or song).

3. **Choose an Activity**:
   - Select an activity type (Playing, Watching, Listening, Streaming, or Stop) from the radio buttons.

4. **Start the Activity**:
   - Click the corresponding button to start the selected activity. The tool will generate and run a Python script to update your Discord status.

5. **Reset Configuration**:
   - Click the "Reset" button to clear the token, topic, and status, and reset the `cfg.json` file.

## Code Overview
### Key Components
- **`edtToken`**: Text field for entering the Discord token.
- **`edtTopic`**: Text field for entering the custom topic.
- **`rbPlay`, `rbWatch`, `rbListen`, `rbStream`, `rbStop`**: Radio buttons for selecting the activity type.
- **`memOutput`**: Memo component for displaying status messages and logs.
- **`memPython`**: Memo component for generating and saving the Python script.
- **`cfg.json`**: JSON file for storing the token, topic, and status.

### Key Functions
- **`btnPwdClick`**: Toggles the visibility of the Discord token.
- **`btnResetClick`**: Resets the configuration and clears the `cfg.json` file.
- **`rbPlayClick`, `rbWatchClick`, `rbListenClick`, `rbStreamClick`, `rbStopClick`**: Handles the selection of different activities and generates the corresponding Python script.
- **`CloseProcessByTitle`**: Closes any running instances of the Python script.

## Future Improvements
- **Support for Custom Images**: Add support for custom images in the Rich Presence.
- **Batch Processing**: Allow users to set multiple activities or topics in sequence.
- **Enhanced Security**: Implement additional security measures for token management.
- **Cross-Platform Support**: Port the tool to other platforms like Python or JavaScript for broader compatibility.

## Credits
- **Developed by**: [Raz](https://github.com/raz-js)
- **Contributions by**: [Theo](https://codeberg.org/its-theo)

---

This tool is provided as-is, and the developers are not responsible for any issues arising from its use. Always follow Discord's Terms of Service when using self-bots or custom Rich Presence tools.
