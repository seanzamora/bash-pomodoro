#!/bin/bash

# Check if an argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <minutes>"
    exit 1
fi

# Get terminal size
TERM_LINES=$(tput lines)
TERM_COLS=$(tput cols)

# Convert minutes to seconds
total_seconds=$((60 * $1))
start_time=$(date +%s)
start_time_formatted=$(date '+%I:%M:%S %p')

# ANSI color codes
YELLOW='\033[1;33m'
NC='\033[0m' # No Color
BG_GRAY='\033[48;5;236m' # Dark gray background

# Unicode block characters for gradient
blocks=(' ' '▏' '▎' '▍' '▌' '▋' '▊' '▉' '█')

# Function to interpolate colors
interpolate_color() {
    local percentage=$1
    local r1=85  # Purple RGB
    local g1=26
    local b1=139
    local r2=0   # Teal RGB
    local g2=128
    local b2=128

    local r=$(( (r2 - r1) * percentage / 100 + r1 ))
    local g=$(( (g2 - g1) * percentage / 100 + g1 ))
    local b=$(( (b2 - b1) * percentage / 100 + b1 ))

    printf "\033[38;2;%d;%d;%dm" $r $g $b
}

# Function to draw the progress bar
draw_progress_bar() {
    local width=50
    local percentage=$1
    local filled_width=$((width * percentage / 100))
    local partial_block=$(( (percentage * width * 8 / 100) % 8 ))
    
    # Clear the screen
    clear

    # Calculate vertical position (centered)
    local v_center=$((TERM_LINES / 2))
    local v_start=$((v_center - 1))
    
    # Print percentage and timer (centered)
    local info_text="  Started: ${start_time_formatted}  Progress: ${percentage}%%  Remaining: $(printf "%02d:%02d" $((remaining / 60)) $((remaining % 60)))"
    local info_text_length=${#info_text}
    local info_text_start=$(( (TERM_COLS - info_text_length) / 2 ))
    printf "\033[${v_start};${info_text_start}H${YELLOW}${info_text}${NC}"
    
    # Print background and progress bar (centered)
    local bar_start=$(( (TERM_COLS - width) / 2 ))
    printf "\033[${v_center};${bar_start}H${BG_GRAY}"
    for ((i = 0; i < width; i++)); do
        if [ $i -lt $filled_width ]; then
            local color=$(interpolate_color $((i * 100 / width)))
            printf "${color}█${NC}${BG_GRAY}"
        elif [ $i -eq $filled_width ] && [ $partial_block -gt 0 ]; then
            local color=$(interpolate_color $percentage)
            printf "${color}${blocks[$partial_block]}${NC}${BG_GRAY}"
        else
            printf " "
        fi
    done
    printf "${NC}"
}

# Hide cursor
printf "\033[?25l"

# Main loop
while true; do
    current_time=$(date +%s)
    elapsed=$((current_time - start_time))
    remaining=$((total_seconds - elapsed))

    if [ $remaining -le 0 ]; then
        percentage=100
        draw_progress_bar $percentage
        # Center the "Timer completed!" message
        # local completed_text="Timer completed!"
        # local completed_text_length=${#completed_text}
        # local completed_text_start=$(( (TERM_COLS - completed_text_length) / 2 ))
        # local completed_text_line=$((TERM_LINES / 2 + 1))
        echo -e "\a"
        break
    fi
    
    percentage=$((100 * elapsed / total_seconds))
    
    # Draw the progress bar
    draw_progress_bar $percentage
    
    sleep 0.1
done

# Show cursor and move it to the bottom of the screen
printf "\033[?25h"
printf "\033[${TERM_LINES};0H"
