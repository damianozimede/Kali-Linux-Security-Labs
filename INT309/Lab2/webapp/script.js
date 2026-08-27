function toggleText() {
    const textEl = document.getElementById('toggleText');
    if (textEl.textContent === 'This text will change when you click the button.') {
        textEl.textContent = 'You clicked the button! Text has changed.';
    } else {
        textEl.textContent = 'This text will change when you click the button.';
    }
}
