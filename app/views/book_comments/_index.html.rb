<table>
<tbody>
    <% @book.book_comments.each do |book_comment| %>
  <tr>
    <td><%= image_tag current_user.get_profile_image(50,50) %><br>
       <%= link_to current_user.name,user_path(current_user.id) %>
    </td>
     <td>
       <%= book_comment.content %>
     </td>
     <% if book_comment.user_id == current_user.id %>
    <td><%= link_to "Destroy", book_book_comment_path(@book.id,book_comment.id),class:"btn bth-sm bg-danger text-white", method: :delete,remote: true, "data-confirm" => "本当に削除しますか？" %></td>
     <% end %>
    </tr>
     <% end %>
</tbody>
</table>