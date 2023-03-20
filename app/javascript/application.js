// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "controllers"

$('.carousel').carousel();
document.addEventListener("DOMContentLoaded", () => {
    const price = document.getElementById('unit-price').getAttribute('data-price'); // Precio unitario del producto
    const totalCostDisplay = document.getElementById("total-cost-display");
    const quantityInput = document.getElementById("quantity-input");
    
    function calculateTotalCost() {
        const quantity = parseInt(quantityInput.value);
        const totalCost = price * quantity;
        totalCostDisplay.innerText = "$" + totalCost.toFixed(2);
    }
    
    quantityInput.addEventListener("change", calculateTotalCost);
});

