# Snippet: Add and Pay Invoices
```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title></title>
  </head>
  <style>
    body {
      font: normal 16px sans-serif;
    }

    h1, h2 {
      margin: 0;
    }

    form {
      float: left;
      width: 300px;
      margin: 20px;
    }

    label {
      display: block;
      margin: 0 0 5px 0;
    }

    input,
    select {
      display: block;
      font: inherit;
      padding: 10px;
      margin: 0 0 10px 0;
      outline: none;
      border: 1px solid #cccccc;
      color: #000000;
      background: #ffffff;
    }

    input[type="submit"] {
      color: #000000;
      background: #44dda0;
      border: none;
      box-shadow: 1px 1px 2px 0 rgba(0, 0, 0, .5);
      cursor: pointer;
    }

    input[type="submit"]:active {
      transform: translateY(1px);
      box-shadow: none;
    }

    table {
      border-collapse: collapse;
      border: 1px solid black;
      clear: both;
    }

    th, td {
      padding: 3px 10px;
    }

    thead {
      border-bottom: 1px solid black;
    }

    tfoot {
      /*border-top: 3px double black;*/
    }

    tfoot > tr:first-child td {
      padding-top: 10px;
      border-top: 2px solid black;
    }

    tfoot td:first-child {
      font-weight: bold;
      text-align: right;
    }
  </style>
  <body>
    <h1>Invoicer</h1>
    <form action="#" method="post">
      <h2>Pay Invoice</h2>
      <label for="accountSelect">Account Name</label>
      <select name="accountSelect" id="accountSelect">
        <option value="Due North Development">Due North Development</option>
        <option value="Moonbeam Interactive">Moonbeam Interactive</option>
        <option value="Slough Digital">Slough Digital</option>
      </select>

      <input type="submit" value="Pay">
    </form>
    <form action="#" method="post">
      <h2>Add Invoice</h2>
      <label for="newAccount">Account Name</label>
      <input type="text" name="newAccount" id="newAccount" value="" />
      <label for="newAmount">Amount</label>
      <input type="number" name="newAmount" id="newAmount" value="" />

      <input type="submit" id="submitNewInvoice" value="Add">
    </form>

    <table>
      <thead>
        <tr>
          <th>Account</th>
          <th>Amount</th>
          <th>Status</th>
        </tr>
      </thead>
      <tbody>
      </tbody>
      <tfoot>
        <tr>
          <td>Total Paid:</td>
          <td id="paid" colspan="2"></td>
        </tr>
        <tr>
          <td>Total Unpaid:</td>
          <td id="unpaid" colspan="2"></td>
        </tr>
      </tfoot>
    </table>
    <script>
      var invoices = {
        unpaid: [],
        paid: [],
        add: function(name, amount) {
          if (typeof amount === "number" && amount === amount) {
            this.unpaid.push({
              name: name, amount: amount
            });
          }
        },
        totalDue: function() {
          return this.unpaid.reduce(function(sum, invoice) {
            return sum + invoice.amount;
          }, 0);
        },
        totalPaid: function() {
          return this.paid.reduce(function(sum, invoice) {
            return sum + invoice.amount;
          }, 0);
        },
        payInvoice: function(name) {
          var stillUnpaid = [];
          for (var i = 0; i < this.unpaid.length; i++) {
            var invoice = this.unpaid[i];
            if (invoice.name === name) {
              this.paid.push(invoice);
            } else {
              stillUnpaid.push(invoice);
            }
          }

          this.unpaid = stillUnpaid;
        },
      }

      function payInvoice(event) {
        event.preventDefault();
        var accountSelect = document.querySelector('[name="accountSelect"]')
        var accountName = accountSelect.selectedOptions[0].getAttribute("value");
        invoices.payInvoice(accountName);
        populateSelectOptions();
        drawInvoiceTable();
      }

      function addNewInvoice(event) {
        event.preventDefault();
        var newAccount = document.getElementById("newAccount");
        var newAmount = document.getElementById("newAmount");
        invoices.add(newAccount.value, parseFloat(newAmount.value, 10));
        newAccount.value = "";
        newAmount.value = "";

        populateSelectOptions();
        drawInvoiceTable();
      }

      function populateSelectOptions() {
        var select = document.getElementById("accountSelect");
        var names = invoices.unpaid.map(function(invoice) {
          return invoice.name;
        })
        var options = unique(names).map(function(name) {
          return '<option value="' + name + '">' + name + '</option>';
        }).join("\n");
        select.innerHTML = options;
      }

      function unique(array) {
        var result = [];
        array.forEach(function(item) {
          if (result.indexOf(item) === -1) {
            result.push(item);
          }
        });
        return result;
      }

      function drawInvoiceTable() {
        document.querySelector("tbody").innerHTML = "";
        invoices.unpaid.forEach(function(inv) {
          addInvoiceToTable(inv, "Unpaid");
        });
        invoices.paid.forEach(function(inv) {
          addInvoiceToTable(inv, "Paid");
        });

        var paid = document.getElementById("paid");
        var unpaid = document.getElementById("unpaid");
        paid.textContent = invoices.totalPaid();
        unpaid.textContent = invoices.totalDue();
      }

      function addInvoiceToTable(invoice, status) {
        var tbody = document.querySelector("tbody");
        var tr = document.createElement("tr");
        var content = "<td>" + invoice.name + "</td>" +
                      "<td>" + invoice.amount + "</td>" +
                      "<td>" + status + "</td>";
        tr.innerHTML = content;
        tbody.appendChild(tr);
      }

      invoices.add('Due North Development', 250);
      invoices.add('Moonbeam Interactive', 187.50);
      invoices.add('Slough Digital', 300);

      document.addEventListener("DOMContentLoaded", function() {
        var submit = document.querySelector('[type="submit"]');
        submit.addEventListener("click", payInvoice);

        var submitNewInvoice = document.getElementById("submitNewInvoice");
        submitNewInvoice.addEventListener("click", addNewInvoice);

        populateSelectOptions();
        drawInvoiceTable();
      });
    </script>
  </body>
</html>
```
