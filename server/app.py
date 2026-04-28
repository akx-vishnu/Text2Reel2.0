import sys
print("Using Python:", sys.executable)
from flask import Flask, request, jsonify, send_file
from moviepy.editor import *
from PIL import Image, ImageDraw, ImageFont
import numpy as np
import os
import sys
from datetime import datetime
import random

app = Flask(__name__, static_folder='../public', static_url_path='')

# Temp folder in root directory
TEMP_DIR = os.path.join(os.path.dirname(__file__), '../temp')
os.makedirs(TEMP_DIR, exist_ok=True)
'''
@app.route('/shutdown', methods=['POST'])
def shutdown():
    os._exit(0)
'''
@app.route('/')
def index():
    return app.send_static_file('index.html')

@app.route('/generate-video', methods=['POST'])
def generate_video():
    data = request.json
    text = data.get('text', '').strip()
    subtext = data.get('subtext', '').strip()

    if not text:
        return jsonify({'error': 'Empty text input'}), 400

    # Unique filename: output_YYYYMMDD_HHMMSS.mp4
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    video_filename = f"output_{timestamp}.mp4"
    video_path = os.path.join(TEMP_DIR, video_filename)

    # Video properties
    width, height = 1080, 1920
    duration = 11
    bg_color = random.choice(["#8569E4"])
    #print(bg_color)
    text_color = "#FFFFFF"

    # Create image
    img = Image.new('RGBA', (width, height), color=bg_color)
    '''
    noise_path = os.path.join(os.path.dirname(__file__), 'fonts', 'brushed-alum-dark.png')
    noise_texture = Image.open(noise_path).convert("RGBA")
    noise_texture = noise_texture.resize((width, height))
    img.alpha_composite(noise_texture)
    '''
    draw = ImageDraw.Draw(img)
    
    # Font setup
    try:
        font_path = os.path.join(os.path.dirname(__file__), 'fonts', 'Montserrat-Bold.ttf')
        sub_font_path = os.path.join(os.path.dirname(__file__), 'fonts', 'Montserrat-Bold.ttf')
        font_size = 50
        font = ImageFont.truetype(font_path, font_size)
        print('success')
    except:
        print('error')
        font = ImageFont.load_default()

    # Function for wrapping text using textbbox (modern Pillow)
    def wrap_text(text, font, max_width):
        lines = []
        for paragraph in text.split("\n"):  # keep user-added newlines
            words = paragraph.split()
            if not words:
                lines.append("")  # preserve empty lines
                continue

            current = ""
            for word in words:
                test_line = f"{current} {word}".strip()
                bbox = draw.textbbox((0, 0), test_line, font=font)
                w = bbox[2] - bbox[0]
                if w <= max_width:
                    current = test_line
                else:
                    lines.append(current)
                    current = word
            if current:
                lines.append(current)
        return "\n".join(lines)


    # Dynamically adjust font size for long text
    wrapped_text = wrap_text(text, font, width * 0.9)
    while True:
        bbox = draw.multiline_textbbox((0, 0), wrapped_text, font=font, align='center', spacing=10)
        text_height = bbox[3] - bbox[1]
        text_width = bbox[2] - bbox[0]

        if (text_height < height * 0.8) and (text_width < width * 0.9):
            break

        font_size -= 3
        if font_size < 20:
            break

        font = ImageFont.truetype(font_path, font_size)
        wrapped_text = wrap_text(text, font, width * 0.9)

    # Center the text
    bbox = draw.multiline_textbbox((0, 0), wrapped_text, font=font, align='center', spacing=10)
    text_x = (width - (bbox[2] - bbox[0])) // 2
    text_y = (height - (bbox[3] - bbox[1])) // 2

    draw.multiline_text((text_x, text_y), wrapped_text, font=font, fill=text_color, align='center', spacing=10)

    #Draw optional subtext below main text
    if subtext:
        # Choose a smaller font for subtext
        try:
            sub_font_size = max(font_size - 20, 28)  # smaller but not tiny
            sub_font = ImageFont.truetype(sub_font_path, sub_font_size)
        except:
            sub_font = ImageFont.load_default()

        # Wrap subtext to fit within 85% width
        wrapped_sub = wrap_text(subtext, sub_font, int(width * 0.85))

        # Measure main text height (already computed in bbox)
        main_text_height = bbox[3] - bbox[1]

        # Compute position for subtext: centered, a bit below the main text
        bbox_sub = draw.multiline_textbbox((0, 0), wrapped_sub, font=sub_font, align='center', spacing=6)
        sub_width = bbox_sub[2] - bbox_sub[0]
        sub_height = bbox_sub[3] - bbox_sub[1]

        sub_x = (width - sub_width) // 2
        # Place subtext below the main text block; adjust if it would collide with bottom copyright
        line_gap = font_size * 1.6
        sub_y = text_y + main_text_height + line_gap

        # if subtext is too low (colliding with bottom area), nudge it up
        bottom_reserved = 220  # pixels reserved for copyright / safe margin
        if sub_y + sub_height + bottom_reserved > height:
            # try reducing font size further until it fits (simple loop)
            while sub_font_size > 16 and (sub_y + sub_height + bottom_reserved > height):
                sub_font_size -= 2
                try:
                    sub_font = ImageFont.truetype(sub_font_path, sub_font_size)
                except:
                    sub_font = ImageFont.load_default()
                wrapped_sub = wrap_text(subtext, sub_font, int(width * 0.85))
                bbox_sub = draw.multiline_textbbox((0, 0), wrapped_sub, font=sub_font, align='center', spacing=6)
                sub_width = bbox_sub[2] - bbox_sub[0]
                sub_height = bbox_sub[3] - bbox_sub[1]
                sub_x = (width - sub_width) // 2

            # if still colliding, move it a bit up
            if sub_y + sub_height + bottom_reserved > height:
                sub_y = max(text_y + main_text_height + 10, height - bottom_reserved - sub_height - 10)

        draw.multiline_text((sub_x, sub_y), wrapped_sub, font=sub_font, fill=(255,255,255,210), align='center', spacing=6)

    # Add copyright text at the bottom center
    copyright_text = "@bonda.comm"  # Change this to whatever you want
    copyright_font_size = 40
    copyright_font = ImageFont.truetype(font_path, copyright_font_size)
    bbox_c = draw.textbbox((0, 0), copyright_text, font=copyright_font)
    c_width = bbox_c[2] - bbox_c[0]
    c_height = bbox_c[3] - bbox_c[1]
    c_x = (width - c_width) // 2
    c_y = height - c_height - 150  # 60px from bottom edge
    draw.text((c_x, c_y), copyright_text, font=copyright_font, fill=(255, 255, 255, 180))

    #img.save("final_output.png")

    # Convert to video (no audio)
    clip = ImageClip(np.array(img)).set_duration(duration)
    clip.write_videofile(video_path, fps=30, codec='libx264', audio=False, preset='medium')

    return jsonify({'videoUrl': '/download/' + video_filename})

@app.route('/download/<filename>')
def download(filename):
    file_path = os.path.join(TEMP_DIR, filename)
    if not os.path.exists(file_path):
        return jsonify({'error': 'File not found'}), 404
    return send_file(file_path, as_attachment=True)

@app.after_request
def skip_ngrok_warning(response):
    response.headers["ngrok-skip-browser-warning"] = "true"
    return response

if __name__ == '__main__':
    import webbrowser
    #webbrowser.open("http://127.0.0.1:10000")
    app.run(host='0.0.0.0', port=10000)


