# Centered Visual Pomodoro Timer

This Bash script creates a visually appealing, centered countdown timer in your terminal window. It features a colorful progress bar and real-time updates.

## Features

- Centered display in the terminal window
- Colorful progress bar with gradient effect
- Real-time updates of progress and remaining time
- Customizable duration
- Completion alert with sound

## Requirements

- Bash shell (version 4.0 or later recommended)
- A terminal that supports ANSI escape sequences and Unicode characters

## Installation

1. Download the script:
   ```
    git clone git@github.com:seanzamora/bash-pomodoro.git
   ```

2. Make the script executable:
   ```
   chmod +x pomodoro.sh
   ```

## Usage

Run the script with the desired number of minutes as an argument:

```
./pomodoro.sh <minutes>
```

For example, to start a 5-minute timer:

```
./pomodoro.sh 5
```

## Customization

You can customize the script by modifying the following variables:

- `YELLOW`: Change the color of the text (uses ANSI color codes)
- `BG_GRAY`: Change the background color of the progress bar
- `blocks`: Modify the Unicode characters used for the progress bar gradient

## Troubleshooting

If the timer is not centered correctly:
- Ensure your terminal window is large enough to display the entire timer.
- Try resizing your terminal window before running the script.
- Check if your terminal fully supports ANSI escape sequences.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Thanks to the Bash community for providing helpful resources on terminal manipulation
