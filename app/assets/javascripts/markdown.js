// $(document).ready(ready);
// $(document).on('page:load', ready);

;(function() {

$(document).on('page:change', function() {
  console.log('doc ready');
  var view = new MdController.View();
  var controller = new MdController(view);
  controller.bindListeners();
});

function MdController(view) {
  this.view = view;
};

MdController.prototype.bindListeners = function() {
  this.view.$questionContent.on('keyup', this.renderInputArray.bind(this));
};

MdController.prototype.renderInputArray = function() {
  var lineArray = [];
  lineArray = this.view.$questionContent.val().split('\n');
  this.view.convertMarkdownFormatting(lineArray);
}


MdController.View = function() {
  this.$questionContent = $('#question_content');
  this.$markdownLiveOutput = $('.markdown-output');
}

MdController.View.prototype.convertMarkdownFormatting = function(lineArray) {
  var convertedArray = [];
  $.each(lineArray, function(index, line) {
    if ((line.match(/#/g) || []).length >= 1) {
      for (var headingIndex = 1; headingIndex <= 6; headingIndex++ ) {
        if ((line.match(/#/g) || []).length == headingIndex) {
          convertedArray.push('<h'+ headingIndex+ ">" + line.match(/[^#]+/) + '</h' + headingIndex + '>');
        }
      }
    } else if ((line.match(/-/g) || []).length >= 3) {
      convertedArray.push('<hr>');
    } else if ((line.match(/[*]/g) || []).length >= 3) {
      convertedArray.push('<hr>');
    } else if ((line.match(/_/g) || []).length >= 3) {
      convertedArray.push('<hr>');
    } else if ((line.match(/`/g) || []).length >= 3) {
      convertedArray.push("<code>" + line.match(/[^`]+/) + "</code>");
    } else if (line.search(/^[1.]+/g)  != -1) {
      convertedArray.push("<li class='numbered-list'>" + line.match(/[^[1.]+]+/) + "</li>");
    } else if ((line.match(/[*]/g) || []).length == 1) {
      convertedArray.push('<li>' + line.match(/[^*]+/) + '</li>');
    } else if ((line.match(/-/g) || []).length == 1) {
      convertedArray.push('<li>' + line.match(/[^-]+/) + '</li>');
    } else if ((line.match(/[+]/g) || []).length == 1) {
      convertedArray.push('<li>' + line.match(/[^+]+/) + '</li>');
    } else if (line[0] == "!") {
      altText = line.match(/\[([^]]+)\]/);
      imageSrc = line.match(/\(([^\)]+)\)/);
      convertedArray.push("<img src='" + imageSrc[1] + "' alt='" + altText + "'>");
    } else if (line == "") {
      console.log('blank line');
    } else {
      convertedArray.push('<p>' + line + '</p>');
    }
  })
console.log(convertedArray.join("\n"))
  this.$markdownLiveOutput.html(convertedArray.join("\n"));
  // $('.markdown-question-output').html(convertedArray.join("\n"))
}

})();
