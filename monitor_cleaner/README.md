
# Monitor Cleaner Tool

A simple full-screen PyGame application designed to help you clean your monitors by displaying solid colors that make dirt and smudges easily visible.

## Features

- **Full-Screen Color Display**: Fills your entire screen with a solid color
- **Multiple Colors**: White, black, gray, red, green, blue, yellow, cyan, magenta
- **Easy Color Switching**: Interactive slider or keyboard controls
- **Hidden Interface**: Clean, unobtrusive controls that appear when needed
- **Cross-Platform**: Works on Windows, macOS, and Linux

## Use Cases

- **Monitor Cleaning**: Easily spot dust, smudges, and dirt on your screen
- **Pixel Testing**: Check for dead or stuck pixels
- **Color Calibration**: Visual reference for color accuracy
- **Presentation Aid**: Simple colored backgrounds

## Installation

### Prerequisites
- Python 3.6 or higher
- PyGame library

### Steps
1. **Create a virtual environment** (recommended):
   ```bash
   python -m venv monitor_cleaner_env
   source monitor_cleaner_env/bin/activate  # On Windows: monitor_cleaner_env\Scripts\activate
   ```

2. **Install PyGame**:
   ```bash
   pip install pygame
   ```

3. **Download** the `monitor_cleaner.py` file

## Usage

### Running the Application
```bash
python monitor_cleaner.py
```

### Controls

| Key | Action |
|-----|---------|
| `ESC` | Exit the application |
| `TAB` | Show/hide color slider |
| `LEFT/RIGHT Arrow` | Cycle through colors (when slider is visible) |

### Mouse Controls (when slider is visible)
- **Click and drag** the slider to select colors
- **Color preview** shows the currently selected color

### Available Colors
- White (perfect for seeing dust and smudges)
- Black (great for checking streaks after cleaning)
- Gray
- Red
- Green  
- Blue
- Yellow
- Cyan
- Magenta

## How to Clean Your Monitor Effectively

1. **Start the application** and press `TAB` to show controls if needed
2. **Select white color** - this makes dust and smudges most visible
3. **Clean your monitor** using appropriate supplies:
   - Microfiber cloth
   - Screen cleaning solution
   - Isopropyl alcohol (70% diluted)
4. **Switch to black color** to check for streaks and residue
5. **Use other colors** to spot different types of imperfections

## Multi-Monitor Support

While the application runs in full-screen on one monitor, you can:
- Use your system's built-in monitor switching (Windows: `Win + Shift + Left/Right`)
- Run multiple instances on different monitors
- Move the application between monitors using your window manager

## Tips for Best Results

- **Use white background** for general cleaning - shows dust best
- **Use black background** to check for streaks after cleaning
- **Turn off room lights** to reduce reflections
- **Clean in a pattern** - top to bottom, left to right
- **Don't press too hard** - use gentle circular motions

## Technical Details

- Built with PyGame for smooth full-screen performance
- Lightweight and fast - minimal system resource usage
- No installation required beyond PyGame
- Source code is simple and easy to modify

## Troubleshooting

### Application won't start
- Ensure PyGame is installed: `pip install pygame`
- Verify Python version is 3.6+
- Check that the file is named `monitor_cleaner.py`

### Can't see the slider
- Press `TAB` key to toggle slider visibility
- Ensure no other applications are intercepting the key press

### Performance issues
- The application is very lightweight, but if issues occur:
  - Close other running applications
  - Update your graphics drivers
  - Ensure PyGame is up to date
