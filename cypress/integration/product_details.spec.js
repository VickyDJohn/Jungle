describe('product details', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000/');
  });

  it("displays product details when clicked", () => {
    cy.get(".products article").first().click()
  })
});