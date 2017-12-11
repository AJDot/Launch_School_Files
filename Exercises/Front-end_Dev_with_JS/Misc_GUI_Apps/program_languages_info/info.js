var languages = [
  {
    name: 'Ruby',
    description: 'Ruby is a dynamic, reflective, object-oriented, ' +
    'general-purpose programming language. It was designed and developed in the mid-1990s ' +
    'by Yukihiro Matsumoto in Japan. According to its creator, Ruby was influenced by Perl, ' +
    'Smalltalk, Eiffel, Ada, and Lisp. It supports multiple programming paradigms, ' +
    'including functional, object-oriented, and imperative. It also has a dynamic type ' +
    'system and automatic memory management.'
  },

  {
    name: 'JavaScript',
    description: 'JavaScript is a high-level, dynamic, untyped, and interpreted ' +
    'programming language. It has been standardized in the ECMAScript language ' +
    'specification. Alongside HTML and CSS, JavaScript is one of the three core ' +
    'technologies of World Wide Web content production; the majority of websites employ ' +
    'it, and all modern Web browsers support it without the need for plug-ins. JavaScript ' +
    'is prototype-based with first-class functions, making it a multi-paradigm language, ' +
    'supporting object-oriented, imperative, and functional programming styles.'
  },

  {
    name: 'Lisp',
    description: 'Lisp (historically, LISP) is a family of computer programming languages ' +
    'with a long history and a distinctive, fully parenthesized prefix notation. ' +
    'Originally specified in 1958, Lisp is the second-oldest high-level programming ' +
    'language in widespread use today. Only Fortran is older, by one year. Lisp has changed ' +
    'since its early days, and many dialects have existed over its history. Today, the best '+
    'known general-purpose Lisp dialects are Common Lisp and Scheme.'
  }
];
var langDiv = document.getElementById('languages');

function writePage() {
  languages.forEach(function(lang) {
    var div = document.createElement('div');
    div.classList.add('lang');
    div.setAttribute('data-lang', lang.name);

    var h2 = document.createElement('h2');
    h2.textContent = lang.name;

    var p = document.createElement('p');
    p.textContent = truncate(lang.description);

    var a = document.createElement('a', );
    a.setAttribute('href', '#');
    a.classList.add('more');
    a.textContent = "Show More";

    div.appendChild(h2);
    div.appendChild(p);
    div.appendChild(a);
    langDiv.appendChild(div);
  });
}

function truncate(text) {
  return text.slice(0, 120) + ' ...';
}

function getLanguage(name) {
  return languages.find(function(langObj) {
    return langObj.name === name;
  });
}

function toggleShow(e) {
  if (e.target.tagName = 'A') {
    var a = e.target;
    var div = a.parentNode;
    var name = div.getAttribute('data-lang');
    var p = div.querySelector('p');

    var description = getLanguage(name).description;

    if (a.textContent === 'Show Less') {
      p.textContent = truncate(description);
      a.textContent = 'Show More';
    } else {
      p.textContent = description;
      a.textContent = 'Show Less'
    }
  }
}

writePage();

langDiv.addEventListener('click', toggleShow);
