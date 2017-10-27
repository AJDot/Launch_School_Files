function makeCountry(name, continent, visited = false) {
  return {
    name: name,
    continent: continent,
    visited: visited,
    visitCountry: function() {
      this.visited = true;
    },
    getDescription: function() {
      return this.name + " is located in " + this.continent + '. I have' +
        (this.visited ? '' : "n't") + ' visited ' + name;
    },
  }
}

var chile = makeCountry("The Republic of Chile", "South America");
var canada = makeCountry("Canada", "North America");
var southAfrica = makeCountry("The Republic of South Africa", "Africa");

chile.getDescription(); // "The Republic of Chile is located in South America."
canada.getDescription(); // "Canada is located in North America."
southAfrica.getDescription(); // "The Republic of South Africa is located in Africa."
