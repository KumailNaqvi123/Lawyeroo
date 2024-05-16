//DIFFERENT ATTRIBUTES OF THE POST

class Post {
  final String id;
  final String title;
  final String content;
  final DateTime creationTime;
  final String userProfilePicture;
  final String userName;
  final List<Comment> comments;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.creationTime,
    required this.userProfilePicture,
    required this.userName,
    required this.comments,
  });

  factory Post.fromJson(String id, Map<String, dynamic> data) {
    List<Comment> comments = [];
    if (data['answers'] != null) {
      data['answers'].forEach((key, value) {
        comments.add(Comment.fromJson(value));
      });
    }
    
    // Improved logging to check what exactly is being parsed
    print("Fetching profile picture: ${data['client']?['profile_picture']}");
    
    return Post(
      id: id,
      title: data['question_title'] ?? 'No title provided',
      content: data['question_text'] ?? 'No content provided',
      creationTime: DateTime.tryParse(data['askedAt']) ?? DateTime.now(),  // Safe parsing of dates
      userProfilePicture: data['client']?['profile_picture'] ?? "default_profile.png",  // Safe access with default
      userName: "${data['client']?['first_name'] ?? 'Anonymous'} ${data['client']?['last_name'] ?? ''}",
      comments: comments,
    );
  }
}

class Comment {
  final String text;
  final String userProfilePicture;
  final String userName;

  Comment({
    required this.text,
    required this.userProfilePicture,
    required this.userName,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    // Ensure we handle the case where lawyer details might be missing
    String profilePicture = json['lawyer']?['profile_picture'] ?? 'default_comment_profile.png';
    String firstName = json['lawyer']?['first_name'] ?? 'Anonymous';
    String lastName = json['lawyer']?['last_name'] ?? '';
    String text = json['lawyer_text'] ?? 'No comment text provided';

    print("Comment by: $firstName $lastName with profile picture $profilePicture");

    return Comment(
      text: text,
      userProfilePicture: profilePicture,
      userName: "$firstName $lastName",
    );
  }
}
