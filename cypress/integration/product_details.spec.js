describe('product details', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000/');
  });

  it("displays the first product's details when clicked", () => {
    cy.get(".products article").first().click()
  })

  it("displays the second product's details when clicked", () => {
    cy.get(".products article").eq(1).click()
  })

  it("displays the last product's details when clicked", () => {
    cy.get(".products article").last().click()
  })
});