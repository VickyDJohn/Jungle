describe('user login', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000/');
  });


  it("user can signup", () => {
    cy.get(".nav-link")
      .contains("Signup").click()
      .get("#user_name").type('test')
      .get("#user_email").type('test@example.com')
      .get("#user_password").type('password')
      .get("#user_password_confirmation").type('password')
      .get(".actions").contains("Submit").click();
  });

  it("user can login", () => {
    cy.get(".nav-link").contains("Login").click()
      .get('input[name="email"]').type('test@test.com')
      .get('input[name="password"]').type('password')
      .get('input[name="commit"]').click()
      .get(".nav-link").contains("Logout")
  });
});