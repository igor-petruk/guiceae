/*
 Copyright (c) 2003-2012, CKSource - Frederico Knabben. All rights reserved.
 For licensing, see LICENSE.html or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function (config) {
    config.toolbar = 'CustomToobar';

    config.toolbar_CustomToobar =
        [
            { name:'document', items:[ 'NewPage', 'Preview' ] },
            { name:'clipboard', items:[ 'Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo' ] },
            { name:'editing', items:[ 'Find', 'Replace', '-', 'SelectAll', '-', 'Scayt' ] },
            { name:'insert', items:[ 'Image', 'Table', 'HorizontalRule', 'Smiley', 'SpecialChar' ] },
            '/',
            { name:'styles', items:[ 'Styles', 'Format', 'Font', 'FontSize' ] },
            { name:'basicstyles', items:[ 'Bold', 'Italic', 'Strike', '-', 'RemoveFormat' ] },
            { name:'paragraph', items:[ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote', 'CreateDiv',
                '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-', 'BidiLtr', 'BidiRtl' ] },
            { name:'links', items:[ 'Link', 'Unlink', 'Anchor' ] },
            { name:'colors', items:[ 'TextColor', 'BGColor' ] },
            { name:'tools', items:[ 'Maximize', 'ShowBlocks' ] }
        ];

};
