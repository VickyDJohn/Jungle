describe('add to cart', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000/');
  });

  it("increases cart by 1 when add to cart is clicked", () => {
    let initialCartCount;
    cy.get(".nav-link")
      .contains("My Cart")
      .invoke("text")
      .then((text) => {
        const cartText = text.split("(")[1].split(")")[0]; // Extract text between parentheses
        initialCartCount = parseInt(cartText, 10);
      });

    // Click the "Add to Cart" button
    cy.contains("Add").click({force: true});

    // Get the updated cart count
    cy.get(".nav-link")
      .contains("My Cart")
      .invoke("text")
      .then((text) => {
        const cartText = text.split("(")[1].split(")")[0]; // Extract text between parentheses
        const updatedCartCount = parseInt(cartText, 10);

        // Verify that the updated cart count is one more than the initial count
        expect(updatedCartCount).to.eq(initialCartCount + 1);
      });
  });
});