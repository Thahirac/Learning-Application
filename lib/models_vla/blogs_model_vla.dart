class BlogsModelVLA {
  String author, blog_link, board_id, date, discription, image, Status, tittle;

  BlogsModelVLA(this.author, this.blog_link, this.board_id, this.date,
      this.discription, this.image, this.Status, this.tittle);

  BlogsModelVLA.fromJson(Map<String, dynamic> json)
      : author = (json['author'] == null) ? "" : json['author'],
        blog_link = (json['blog_link'] == null) ? "" : json['blog_link'],
        board_id = (json['board_id'] == null) ? "" : json['board_id'],
        date = (json['date'] == null) ? "" : json['date'],
        discription = (json['discription'] == null) ? "" : json['discription'],
        image = (json['image'] == null) ? "" : json['image'],
        Status = (json['Status'] == null) ? "" : json['Status'],
        tittle = (json['tittle'] == null) ? "" : json['tittle'];

  Map<String, dynamic> toJson() => {
        'author': author,
        'blog_link': blog_link,
        'board_id': board_id,
        'date': date,
        'discription': discription,
        'image': image,
        'Status': Status,
        'tittle': tittle,
      };
}
//TODO KEEP MORE TO LEFT
