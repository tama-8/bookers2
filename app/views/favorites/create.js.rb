$('#favorite_bth_<%= @book.id %>').html("<%= j(render "favorites/favorite", book: @book) %>");
