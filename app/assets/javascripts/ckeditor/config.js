CKEDITOR.editorConfig = function( config )
{
    config.toolbar = "article";
    
    config.toolbar_article =
    [
        { name: 'clipboard', items : [
                'Undo',
                'Redo' ] },
        { name: 'styles', items : [
                'Format',
                'Font',
                'FontSize'] },
        { name: 'basicstyles', items : [
                'Bold',
                'Italic',
                'Strike',
                'Subscript',
                'Superscript',
                '-',
                'TextColor',
                'BGColor',
                '-',
                'RemoveFormat' ] },
        { name: 'insert', items : [
                'Smiley',
                'SpecialChar',
                'Table',
                'HorizontalRule'] },
        { name: 'paragraph', items : [
                'JustifyLeft',
                'JustifyCenter',
                'JustifyRight',
                'JustifyBlock',
                '-',
                'NumberedList',
                'BulletedList',
                '-',
                'Outdent',
                'Indent' ] },
        { name: 'links', items : [
                'Link',
                'Unlink',
                'Anchor' ] },
        { name: 'tools', items : [
                'Maximize',
                '-',
                'About' ] },
    ];
};

CKEDITOR.replace( 'article_content', {
	toolbar: "article"
});