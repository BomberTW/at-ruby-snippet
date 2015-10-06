AtRubySnippetView = require './at-ruby-snippet-view'
{CompositeDisposable} = require 'atom'

module.exports = AtRubySnippet =
  atRubySnippetView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atRubySnippetView = new AtRubySnippetView(state.atRubySnippetViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atRubySnippetView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'at-ruby-snippet:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atRubySnippetView.destroy()

  serialize: ->
    atRubySnippetViewState: @atRubySnippetView.serialize()

  toggle: ->
    console.log 'AtRubySnippet was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
