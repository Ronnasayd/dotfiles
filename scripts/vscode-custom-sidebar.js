const interval = setInterval(() => {
  const sidebar = document.querySelector(
    'body > div > div.monaco-grid-view > div > div > div.monaco-scrollable-element > div.split-view-container > div:nth-child(3) > div > div > div.monaco-scrollable-element > div.split-view-container > div:nth-child(2)'
  )
  if (!!sidebar) {
    clearInterval(interval)
    execute(sidebar)
  }
}, 2000)

function execute(sidebar) {
  const dbClickEvent = new Event('dblclick', {
    bubbles: true,
    cancelable: true
  })

  const toClick = document.querySelector(
    'body > div > div.monaco-grid-view > div > div > div.monaco-scrollable-element > div.split-view-container > div:nth-child(3) > div > div > div.sash-container > div:nth-child(3)'
  )

  // Cria o observer
  const observer = new MutationObserver(mutationsList => {
    for (const mutation of mutationsList) {
      if (
        mutation.type === 'attributes' &&
        mutation.attributeName === 'style'
      ) {
        if (sidebar.offsetWidth <= 500) {
          toClick.dispatchEvent(dbClickEvent)
        }
      }
    }
  })

  // Configura o observer para observar mudanças de atributos
  observer.observe(sidebar, { attributes: true, attributeFilter: ['style'] })
  console.log('Sidebar auto-expand script loaded.')
}
