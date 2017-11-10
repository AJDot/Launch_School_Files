var posts = [
  {
    title: 'Lorem ipsum dolor sit amet',
    published: 'April 1, 2015',
    body: 'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit.',
    tags: ["Latin", "Gibberish", "Old"],
  },
  {
    title: 'Lorem ipsum dolor sit amet',
    published: 'April 3, 2015',
    body: 'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit.',
  },
]

posts.forEach(function(post) {
  post.body = '<p>' + post.body + '</p>'
});

$(function() {
  var postTemplate = Handlebars.compile($('#post').html());

  Handlebars.registerPartial('tagsTemplate', $('#tag').html());

  $('body').append(postTemplate({ posts: posts }));
});
