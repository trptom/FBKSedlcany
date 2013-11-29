function FileUploader(selectElement, previewElement) {
    _this = this;

    this.reader = new FileReader();

    if (selectElement) {
        this.selectElement = (typeof selectElement === "string") ?
                document.getElementById(selectElement) : selectElement;
    } else {
        this.selectElement = document.createElement("input");
        this.selectElement.type = "file";
    }

    $(this.selectElement).change(function(e) {
        _this.reload(e);
    });

    if (previewElement) {
        this.previewElement = (typeof previewElement === "string") ?
                document.getElementById(previewElement) : previewElement;
    } else {
        this.previewElement = document.createElement("img");
    }
}

FileUploader.prototype = {
    reload: function() {
        this.reader.onload = function (e) {
            $(this.previewElement)
                    .attr('src', e.target.result)
                    .width(150)
                    .height(200);
        };

        this.reader.readAsDataURL(this.selectElement.files[0]);
    },

    reader: null,
    selectElement: null,
    previewElement: null
}