<h2>Add a voucher code</h2>

<div style="width: 600px; margin: auto;">

<fieldset>

<p class="label">
<span class="mandatory">*</span>
<label for="voucher_code.count">Count:</label>
</p><p class="entries">
<% h.text_field('voucher_code.count', size=5) %>
</p><p class="note">
How many voucher codes to generate.
</p>

<p class="label">
<span class="mandatory">*</span>
<label for="voucher_code.leader_id">Group leader:</label>
</p><p class="entries">
<% h.text_field('voucher_code.leader_id', size=5) %>
</p><p class="note">
ID of person who should be given the codes and
allowed to see who's using them, as per <a href="/profile">the profile
list</a>. If nobody, use your own ID: <% c.signed_in_person.id %>
</p>

<p class="label">
<label for="voucher_code.code">Code prefix:</label>
</p><p class="entries">
<% h.text_field('voucher_code.code', size=40) %>
</p><p class="note">
If you enter "foo", it might generate
"foo-ooH4epe7". If blank, it'll just generate "ooH4epe7". Theoretically it
might be a good idea to avoid 1, l, I, 0 and O, but I'm not sure how else one
would spell IBM or GOOGLE :-) 
</p>

<p class="label">
<span class="mandatory">*</span>
<label for="voucher_code.type">Rego Type</label>
</p><p class="entries">
# FIXME: dynamic content
% for t in ['Professional', 'Hobbyist', 'Concession', 'Fairy Penguin Sponsor']:
<input type="radio" name="voucher_code.type" id="voucher_code.type_<% t %>" value="<% t %>" />
<label for="voucher_code.type_<% t %>"><% t %></label>
<br />
% #endfor
</p>

<p class="label">
<span class="mandatory">*</span>
<label for="voucher_code.percentage">Percentage Discount:</label>
</p><p class="entries">
<% h.text_field('voucher_code.percentage', size=5) %>
</p><p class="note">
Between 0-100
</p>

<p class="label">
<span class="mandatory">*</span>
<label for="voucher_code.comment">Comment:</label>
</p><p class="entries">
<% h.text_field('voucher_code.comment', size=60) %>
</p><p class="note">
Why are they getting a voucher? <b>This will appear on the invoices</b>
as the item description for the negative amount - phrase accordingly...
</p>
</fieldset>


</div>