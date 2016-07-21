{ Icon } = antd

module.exports = Search = React.createClass
  render: ->
    <div className='search-input'>
      <Icon type='search' />
      <input placeholder={@props.placeholder} />
    </div>