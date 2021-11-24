class StringHelper {
  // menambahkan koma pada tiga angka belakang
  /* 
    var input = '10000'
    addComma(input)
    hasilnya = '10.000'
  */
  static addComma(String input) {
    return input.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }

  // menjadikan huruf awal capital
  /*
    var input = 'john doe'
    toTileCase(input)
    hasilnya 'John Doe'
  */
  static toTitleCase(String input) {
    return input.toLowerCase().split(' ').map((word) {
      String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
      return word[0].toUpperCase() + leftText;
    }).join(' ');
  }
}
