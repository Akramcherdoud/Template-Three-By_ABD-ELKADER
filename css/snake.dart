// Constants
const canvasSize = 400;
const gridSize = 20;
const snakeColor = "#00FF00";
const foodColor = "#FF0000";

// Variables
let snake = [{ x: 0, y: 0 }];
let food = { x: 0, y: 0 };
let direction = "right";

// Create the canvas
const canvas = document.createElement("canvas");
canvas.width = canvasSize;
canvas.height = canvasSize;
document.body.appendChild(canvas);
const ctx = canvas.getContext("2d");

// Generate random coordinates for the food
function generateFood() {
  food.x = Math.floor(Math.random() * (canvasSize / gridSize)) * gridSize;
  food.y = Math.floor(Math.random() * (canvasSize / gridSize)) * gridSize;
}

// Update the game state
function update() {
  // Move the snake
  const head = { x: snake[0].x, y: snake[0].y };
  switch (direction) {
    case "up":
      head.y -= gridSize;
      break;
    case "down":
      head.y += gridSize;
      break;
    case "left":
      head.x -= gridSize;
      break;
    case "right":
      head.x += gridSize;
      break;
  }
  snake.unshift(head);

  // Check if the snake ate the food
  if (head.x === food.x && head.y === food.y) {
    generateFood();
  } else {
    snake.pop();
  }

  // Check for game over conditions
  if (
    head.x < 0 ||
    head.x >= canvasSize ||
    head.y < 0 ||
    head.y >= canvasSize ||
    snake.slice(1).some((segment) => segment.x === head.x && segment.y === head.y)
  ) {
    clearInterval(gameLoop);
    alert("Game Over!");
  }

  // Clear the canvas
  ctx.clearRect(0, 0, canvasSize, canvasSize);

  // Draw the snake
  snake.forEach((segment) => {
    ctx.fillStyle = snakeColor;
    ctx.fillRect(segment.x, segment.y, gridSize, gridSize);
  });

  // Draw the food
  ctx.fillStyle = foodColor;
  ctx.fillRect(food.x, food.y, gridSize, gridSize);
}

// Handle keyboard input
document.addEventListener("keydown", (event) => {
  switch (event.key) {
    case "ArrowUp":
      direction = "up";
      break;
    case "ArrowDown":
      direction = "down";
      break;
    case "ArrowLeft":
      direction = "left";
      break;
    case "ArrowRight":
      direction = "right";
      break;
  }
});

// Start the game loop
const gameLoop = setInterval(update, 100);
