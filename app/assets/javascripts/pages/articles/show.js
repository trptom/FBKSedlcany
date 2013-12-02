$(document).ready(function() {
    $(".rating-input > i").click(function() {
        $.ajax({
            url: "/articles/"+$("#article-id").val()+"/set_mark.json",
            type: "POST",
            dataType: "json",
            data: {
                value: $(this).attr("data-value")
            }
        }).success(function(data) {
            $("#avg-rating").html(data.avg);
        }).error(function () {
        });
    });
    
    $(".rating-clear").click(function() {
        $.ajax({
            url: "/articles/"+$("#article-id").val()+"/set_mark.json",
            type: "POST",
            dataType: "json",
            data: {
                value: 0
            }
        }).success(function(data) {
            $("#avg-rating").html(data.avg);
        }).error(function () {
        });
    });
});
