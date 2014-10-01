var Comment = React.createClass({
  getInitialState: function() {
    return { likeCount: this.props.comment.likeCount }
  },
  like: function() {
    var newLikeCount = self.state.likeCount + 1;
    this.setState({ likeCount: newLikeCount });
    var commentURL = '/comments/' + this.props.comment.id;
    $.post(commentURL, {
      comment: {
        likeCount: newLikeCount
      }
    });
  },
  render: function() {
    return React.DOM.div({
      children: [
        React.DOM.p({
          className: 'CommentAuthor',
          children: this.props.comment.user_name + ' | ' + this.props.comment.created_at
        }),
        React.DOM.p({
          className: 'CommentBody',
          children: this.props.comment.body
        }),
        React.DOM.p({
          className: 'CommentLike',
          children: [
            React.DOM.span({
              children: 'Like',
              onClick: this.like
            }),
            React.DOM.span({
              className: 'LikeCount',
              children: this.state.likeCount
            })
          ]
        })
      ]
    })
  }
})

var NewCommentField = React.createClass({
  submitComment: function(e) {
    e.preventDefault();
    var newComment = {
      body: this.refs.commentBody.getDOMNode().value,
      user_name: document.getElementById('userName').innerHTML,
      created_at: Date.now(),
      likeCount: 0
    }
    this.props.addComment(newComment);
    $.post('/comments', {
      comment: {
        body: this.refs.commentBody.getDOMNode().value,
        post_id: document.getElementById('postID').innerHTML
      }}, function(resp) {
        newComment.id = resp.id;  // Expects server to return ID
      }
    )
  },
  render: function() {
    return React.DOM.form({
      action: '/comments',
      method: 'POST',
      onSubmit: this.submitComment,
      children: [
        React.DOM.input({
          type: 'text',
          name: 'comment_body',
          ref: 'commentBody',
          placeholder: 'Say something'
        }),
        React.DOM.button({
          type: 'submit',
          children: 'Add comment'
        })
      ]
    })
  }
})

var CommentList = React.createClass({
  getInitialState: function() {
    return { comments: this.props.comments }
  },
  addComment: function(newComment) {
    allComments = this.state.comments;
    allComments.push(newComment);
    this.setState({ comments: allComments });
  },
  render: function() {
    var comments = this.state.comments.map(function(aComment) {
      return React.DOM.li({
        children: Comment({ comment: aComment })
      });
    });
    comments.push(NewCommentField({ addComment: this.addComment }));
    return React.DOM.ol({
      className: 'CommentList',
      children: comments
    });
  }
});

$.get('/comments.json', function(resp) {
  React.renderComponent(CommentList({ comments: resp }), document.getElementById('comments'));
});