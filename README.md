# Text2Reel

A web application and automation tool to convert text into engaging reels and short videos automatically.

## Features

- Generate videos from text prompts.
- Web interface for easy video creation.
- Automated batch scripts for quick reel making.

## Getting Started

### Prerequisites

- Python 3.10+
- FFmpeg
- ImageMagick

### Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd Text2Reel2.0
   ```

2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

3. Run the server:
   ```bash
   python server/app.py
   ```

### Docker Setup

You can also run this application using Docker:

```bash
docker build -t text2reel .
docker run -p 5000:5000 text2reel
```
