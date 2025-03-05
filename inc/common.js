/*
 * building an idea on the use of templates and data
 * render a json object into html
 * <template> serves as page fragments, with 'data' attributes to indicate the key which matches the displayed value
 * data-text - matching key is placed in text $().text()
 * data-val - matches $(this).val()
 * data-each - when the json is an array children of the are rendered using the given template
 *
 */
$.fn.extend({
    //
    render: function(data) {
        let el = $(this)
        let text = el.attr('data-text')
        if (text.length) {
            el.text(data.get(text))
        }
        let val = el.attr('data-val')
        if (val.length) {
            el.val(data.get(val))
        }
        let each = el.attr('data-each')
        if (each.length) {
            el.empty()
            let template = $(`#${each}`)
            for (const child in data) {
                el.append(template.clone().render(child))
            }
        }
        return this // enable chaining
    },
    collect: function() {
        let el = $(this)
        let text = el.attr('data-text')
        if (text.length) {
            return el.text()
        }
        let val = el.attr('data-val')
        if (val.length) {
            return el.val()
        }
        let each = el.attr('data-each')
        if (each.length) {
            el.empty()
            let template = $(`#${each}`)
            for (const child in data) {
                el.append(template.clone().render(child))
            }
        }
        let ret = {}
        let sel = '[data-val],[data-text],[data-each]'
        // nonrecursively find children
        let children = $(this).find(sel).closest().nextAll(sel)
        for (const child in children) {
        }
        return ret

    }

})

// enable mermaid diagrams
mermaid.initialize({ startOnLoad: false });
$(document).ready(function() {
    mermaid.run({
        querySelector: '.language-mermaid',
    });
})
