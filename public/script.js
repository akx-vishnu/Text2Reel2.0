const form = document.getElementById('textForm');
const resultDiv = document.getElementById('result');
const progressContainer = document.getElementById('progressContainer');
const progressBar = document.getElementById('progress');
const submitBtn = form.querySelector('button[type="submit"]');

form.addEventListener('submit', async (e) => {
  e.preventDefault();

  // collect inputs
  let text = document.getElementById('textInput').value.trim();
  let subtext = document.getElementById('subtextInput')?.value.trim() || '';

  const capitalize = document.getElementById('capitalizeToggle').checked;

  // Title Case function
  function toTitleCase(str) {
    return str.toLowerCase().replace(
      /(^|[\s"(){}[\].,!?;:'])([a-z])/g,
      (match, boundary, letter, offset) => {
  
        // If boundary is apostrophe AND it's part of a contraction, skip
        if (
          boundary === "'" && 
          offset > 0 && 
          /[a-z]/i.test(str[offset - 1])  // previous char is a letter
        ) {
          return match;
        }
  
        return boundary + letter.toUpperCase();
      }
    );
  }  
  
  // Apply transform only if checkbox is checked
  if (capitalize) {
    text = toTitleCase(text);
    subtext = toTitleCase(subtext);
  }


  // reset UI
  resultDiv.innerHTML = '';
  progressBar.style.width = '0%';

  if (!text) {
    resultDiv.textContent = 'Please enter some text.';
    return;
  }

  // show progress and lock UI
  progressContainer.classList.remove('hidden');
  submitBtn.disabled = true;
  submitBtn.style.opacity = 0.7;

  let progress = 0;
  const fakeProgress = setInterval(() => {
    if (progress < 90) {
      progress += Math.random() * 5;
      progress = Math.min(progress, 90);
      progressBar.style.width = `${progress}%`;
    }
  }, 500);

  try {
    const response = await fetch('/generate-video', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ text, subtext }), // send both fields
    });

    // try to parse JSON safely
    const result = await response.json().catch(() => null);
    clearInterval(fakeProgress);
    progressBar.style.width = '100%';

    if (response.ok && result && result.videoUrl) {
      // small delay to let the progress bar hit 100%
      setTimeout(() => {
        progressContainer.classList.add('hidden');
        submitBtn.disabled = false;
        submitBtn.style.opacity = 1;

        // show link for manual download & auto-download
        const linkHtml = `<a href="${result.videoUrl}" download>Download Your Video</a>`;
        resultDiv.innerHTML = linkHtml;
        animateResult();

        // auto-trigger download
        const a = document.createElement('a');
        a.href = result.videoUrl;
        a.download = ''; // filename from server will be used
        document.body.appendChild(a);
        a.click();
        a.remove();
      }, 600);
    } else {
      progressContainer.classList.add('hidden');
      submitBtn.disabled = false;
      submitBtn.style.opacity = 1;
      const msg = (result && result.error) ? result.error : 'Error generating video.';
      resultDiv.textContent = msg;
    }
  } catch (error) {
    clearInterval(fakeProgress);
    progressContainer.classList.add('hidden');
    submitBtn.disabled = false;
    submitBtn.style.opacity = 1;
    resultDiv.textContent = 'Something went wrong. Check console for details.';
    console.error('Video generation error:', error);
  }
});

// smooth reveal when showing result
function animateResult() {
  resultDiv.style.opacity = 0;
  setTimeout(() => {
    resultDiv.style.transition = "opacity 0.4s ease";
    resultDiv.style.opacity = 1;
  }, 50);
}
