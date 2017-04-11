var PWB_COOKIE="_Search_Result_PWB_Tree";
var EXPAND = "expand";
var COLLAPSE = "collapse"; // default value for the Location in PWB

$(document).ready(function () {
    $('#local-searchbox').autocomplete({
        serviceUrl: '/content/getTags',
        minChars: 2,
        deferRequestBy: 250,
        paramName: "tagName",
        delimiter: ",",
        transformResult: function (response) {
            return {
                suggestions: $.map($.parseJSON(response), function (item) {
                    return {value: item};
                })
            };
        },
        onSelect: function (value, data) {
            $("#search_form").submit()
        }
    });

    // read cookie when loading page for the first time
    var pwb_cookie = readCookie(PWB_COOKIE);
    // PWB Tree always collapse if cookie not set.
    togglePwbTree(pwb_cookie == null ? COLLAPSE : pwb_cookie);
});

$('ul.term-list').each(function () {
    var LiN = $(this).find('li').length;
    if (LiN > 6) {
        $('li', this).eq(5).nextAll().hide().addClass('toggleable');
        $(this).append('<li class="more">More...</li>');
    }
});


$('ul.term-list').on('click', '.more', function () {
    if ($(this).hasClass('less')) {
        $(this).text('More...').removeClass('less');
    } else {
        $(this).text('Less...').addClass('less');
    }
    $(this).siblings('li.toggleable').slideToggle();
});

$('#search_form').submit(function (e) {
    if (!$('#local-searchbox').val()) {
        e.preventDefault();
    } else if ($('#local-searchbox').val().match(/^\s*$/)) {
        e.preventDefault();
    }
});

$(".plus").click(function () {
    $plus = $(this);
    $treeContent = $plus.nextAll().eq(0);
    $treeContent.slideToggle(500, function () {
        if ($treeContent.is(":visible")) {
            return $plus.find(".sprite-plus").attr("class", "sprite-resize-small sprite sprite-minus");
        } else {
            return $plus.find(".sprite-minus").attr("class", "sprite-resize-small sprite sprite-plus");
        }
    });
});

$('#availableSpeciesSel').ready(function () {
    var DEFAULT_SPECIES = 'Homo sapiens';

    /** Check if hash is present in the URL **/
    var hash = decodeURIComponent(window.location.hash);
    var defaulLoaded = false;
    if (hash == "") {
        $("div[class*=tplSpe_]").each(function (index, value) {
            var item = $(value).attr("class");
            if (item == "tplSpe_" + DEFAULT_SPECIES.replace(" ", "_")) {
                $("#availableSpeciesSel").val(DEFAULT_SPECIES.replace(" ", "_"));
                $("." + item).show();

                //change url
                if ($("#availableSpeciesSel").val() != null) {
                    window.location.hash = "#" + encodeURIComponent(DEFAULT_SPECIES);
                }

                defaulLoaded = true;
            } else {
                $("." + item).css("display", "none");
            }
        });

        if (!defaulLoaded) {
            $("div[class*=tplSpe_]").css("display", "block");
        }
    } else {
        hash = hash.replace("#", "").replace(" ", "_");

        // hash has been change manually into a non-existing value. Pick the first one which is human
        if ($(".tplSpe_" + hash).val() == null) {

            $("#availableSpeciesSel > option").each(function (index, value) {
                var item = $(value).attr("value");

                $("#availableSpeciesSel").val(item);

                $(".tplSpe_" + item).show();
                window.location.hash = "#" + encodeURIComponent(item.replace("_", " "));

                return false;
            });
        } else {
            $("#availableSpeciesSel").val(hash);
            $(".tplSpe_" + hash).show();
        }
    }
});

$('#availableSpeciesSel').on('change', function () {
    var selectedSpecies = this.value;

    // hide everything
    $("div[class*=tplSpe_]").each(function (index, element) {
        $(element).hide();
    });

    // show div related to the species
    $(".tplSpe_" + selectedSpecies).show();

    // change anchor in the URL
    window.location.hash = "#" + encodeURIComponent(selectedSpecies.replace("_", " "));

});

// expand and collapse all feature
$("#pwb_toggle").click(function () {
    var action = $("#pwb_toggle").attr("class");
    togglePwbTree(action);
    writeCookie(PWB_COOKIE, action);
});

function togglePwbTree(action){
    var treeContent = $("div.treeContent");
    treeContent.each(function (index, element) {
        if (action == EXPAND) {
            $(element).show();
        } else {
            $(element).hide(100);
        }
    });

    if (action == COLLAPSE) {
        $(".sprite-minus").attr("class", "sprite-resize-small sprite sprite-plus");
        $("#pwb_toggle").text("Expand All");
        $("#pwb_toggle").attr("class", EXPAND);
    } else {
        $(".sprite-plus").attr("class", "sprite-resize-small sprite sprite-minus");
        $("#pwb_toggle").text("Collapse All");
        $("#pwb_toggle").attr("class", COLLAPSE);
    }
}

function readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
}

function writeCookie(key, value) {
    var date = new Date();
    // Default at 365 days.
    var days = 365;
    // Get unix milliseconds at current time plus number of days
    date.setTime(+ date + (days * 86400000)); //24 * 60 * 60 * 1000
    document.cookie = key + "=" + value + "; expires=" + date.toGMTString() + ";";
}