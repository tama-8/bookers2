$('#favorite_btn_<%= @book.id %>').html("<%= j(render "favorites/favorite", book: @book) %>");
