function selectTopArticle(id) {
    $(".top-articles .image").hide();
    $(".top-articles .title").removeClass("selected");
    $(".top-articles .image-" + id).show();
    $(".top-articles .title-" + id).addClass("selected");
}

$(document).ready(function() {
    selectTopArticle(0);
});