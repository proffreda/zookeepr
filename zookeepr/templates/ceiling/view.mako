<%inherit file="/base.mako" />

    <h2>View ceiling</h2>

    <p><b>Name:</b> ${ c.ceiling.name }<br></p>
    <p><b>Limit:</b> ${ c.ceiling.max_sold | h }<br></p>
    <p>
      <b>Available From:</b>
% if c.ceiling.available_from:
      ${ c.ceiling.available_from.strftime('%d/%m/%y') | h }
% endif
      <br>
    </p>
    <p>
      <b>Available Until:</b>
% if c.ceiling.available_until:
      ${ c.ceiling.available_until.strftime('%d/%m/%y') | h }
% endif
      <br>
    </p>
    <p><b>Currently Available:</b> ${ h.yesno(c.ceiling.available()) | n } <br></p>
    <p><b>Invoiced:</b> ${ c.ceiling.qty_invoiced() | h }<br></p>
    <p><b>Sold:</b> ${ c.ceiling.qty_sold() | h }<br></p>

    <h3>Products in this Ceiling</h3>
    <p><b>Note:</b> Totals are not necessarily accurate as they do not take into account for vouchers. They are simply paid items times cost.</p>
    <table>
      <thead><tr>
        <th>Description</th>
        <th>Category</th>
        <th>Active</th>
        <th>Cost</th>
        <th>Invoiced (inc. overdue)</th>
        <th>Valid Invoices</th>
        <th>Sold</th>
        <th>Total</th>
      </tr></thead>
<% ceiling_total = 0 %>
% for product in c.ceiling.products:
<%   ceiling_total += product.qty_sold() * product.cost %>
      <tr>
        <td>${ h.link_to(product.description, url=h.url_for(controller='product', action='view', id=product.id)) }</td>
        <td>${ product.category.name | h }</td>
        <td>${ h.yesno(product.active) | n }</td>
        <td>${ h.number_to_currency(product.cost/100.0) }</td>
        <td>${ product.qty_invoiced(date=False) | h }</td>
        <td>${ product.qty_invoiced() | h }</td>
        <td>${ product.qty_sold() | h }</td>
        <td>${ h.number_to_currency((product.qty_sold() * product.cost)/100) }</td>
      </tr>
% endfor
      <tr>
        <td colspan="7" style="font-weight: bold; text-align: right;">Total:</td>
        <td>${ h.number_to_currency(ceiling_total/100) }</td>
    </table>
    
    <h3>Sales in this Ceiling</h3>
    <table>
      <thead><tr>
        <th>Invoice</th>
        <th>Person</th>
        <th>Product</th>
        <th>Qty</th>
        <th>Status</th>
      </tr></thead>
% for product in c.ceiling.products:
%   for invoice_item in product.invoice_items:
%        if invoice_item.invoice.paid():
      <tr>
        <td>${ h.link_to('id: ' + str(invoice_item.invoice.id), url=h.url_for(controller='invoice', action='view', id=invoice_item.invoice.id)) }</td>
        <td>${ h.link_to(invoice_item.invoice.person.firstname + ' ' + invoice_item.invoice.person.lastname, h.url_for(controller='person', action='view', id=invoice_item.invoice.person.id)) }</td>
        <td>${ invoice_item.description }</td>
        <td>${ invoice_item.qty }</td>
        <td>${ invoice_item.invoice.status() }</td>
      </tr>
%        endif
%   endfor
% endfor
    </table>

    <h3>Invoices in this Ceiling</h3>
    <table>
      <thead><tr>
        <th>Invoice</th>
        <th>Person</th>
        <th>Product</th>
        <th>Qty</th>
        <th>Status</th>
      </tr></thead>
% for product in c.ceiling.products:
%   for invoice_item in product.invoice_items:
%        if not invoice_item.invoice.is_void() and not invoice_item.invoice.paid():
      <tr>
        <td>${ h.link_to('id: ' + str(invoice_item.invoice.id), url=h.url_for(controller='invoice', action='view', id=invoice_item.invoice.id)) }</td>
        <td>${ h.link_to(invoice_item.invoice.person.firstname + ' ' + invoice_item.invoice.person.lastname, h.url_for(controller='person', action='view', id=invoice_item.invoice.person.id)) }</td>
        <td>${ invoice_item.description }</td>
        <td>${ invoice_item.qty }</td>
        <td>${ invoice_item.invoice.status() }</td>
      </tr>
%        endif
%   endfor
% endfor
    </table>

    <h3>Invalid Invoices in this Ceiling</h3>
    <table>
      <thead><tr>
        <th>Invoice</th>
        <th>Person</th>
        <th>Product</th>
        <th>Qty</th>
        <th>Status</th>
      </tr></thead>
% for product in c.ceiling.products:
%   for invoice_item in product.invoice_items:
%        if not invoice_item.invoice.paid() and invoice_item.invoice.is_void():
      <tr>
        <td>${ h.link_to('id: ' + str(invoice_item.invoice.id), url=h.url_for(controller='invoice', action='view', id=invoice_item.invoice.id)) }</td>
        <td>${ h.link_to(invoice_item.invoice.person.firstname + ' ' + invoice_item.invoice.person.lastname, h.url_for(controller='person', action='view', id=invoice_item.invoice.person.id)) }</td>
        <td>${ invoice_item.description }</td>
        <td>${ invoice_item.qty }</td>
        <td>${ invoice_item.invoice.status() }</td>
      </tr>
%        endif
%   endfor
% endfor
    </table>

    <p>
    ${ h.link_to('Edit', url=h.url_for(action='edit',id=c.ceiling.id)) } |
    ${ h.link_to('Back', url=h.url_for(action='index', id=None)) }</p>