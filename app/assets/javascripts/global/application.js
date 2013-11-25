$(document).ready(function() {
    $('[data-behaviour~=datepicker]').datepicker({
        format: 'yyyy-mm-dd'
    });
    
    $('[data-behaviour~=timepicker]').timepicker({
        minuteStep: 1,
        template: 'modal',
        appendWidgetTo: 'body',
        showSeconds: true,
        showMeridian: false,
        defaultTime: false
    });
});

/**
 * Prida zadany text do prave aktivni (focused) textarey. Pokud neni zadna area
 * aktivni, pouzije se alternativa. Pokud alternativa neni uvedena nebo nejde
 * o textareu, nestane se nic.
 * @param {String} text pridavany text.
 * @param {HTMLElement|String} alternative alternativni area pro pripad,
 * ze zadna neni focused. Pokud je zadan String, je nahrayen elementem
 * s prislusnym id.
 * @return {HTMLElement} element, kam byl text pridan nebo null, pokud nebyl
 * pridan nikam.
 */
function add_into_active_area(text, alternative) {
    var elem = document.activeElement;
    if (elem && elem.tagName && elem.tagName.toLowerCase() == "textarea") {
        elem.innerHTML += text;
        return elem;
    } else {
        return add_into_text_area(text, alternative);
    }
    return null;
}

/**
 * Prida text k textu v elementu textarea.
 * @param {String} text pridavany text
 * @param {HTMLElement|String} area textarea, do ktere se ma text pridat. Pokud
 * je zadan String, je nalezen element se stejnym id.
 * @return {HTMLElement} element, kam byl text pridan nebo null, pokud nebyl
 * pridan nikam.
 */
function add_into_text_area(text, area) {
    if (typeof area === "string") {
        area = document.getElementById(area);
    }
    if (area && area.tagName && area.tagName.toLowerCase() == "textarea") {
        area.innerHTML = area.innerHTML + text;
        return area;
    }
    return false;
}
