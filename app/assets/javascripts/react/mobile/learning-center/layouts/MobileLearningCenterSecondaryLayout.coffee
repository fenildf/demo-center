{ Icon } = antd

module.exports = MobileLearningCenterSecondaryLayout = React.createClass
  render: ->
    title = @props.title

    <div className='mobile-learning-center secondary'>
      <HeaderBar title={title} back_to={@props.back_to} />
      <MobileContent>
        {@props.children}
      </MobileContent>
    </div>

HeaderBar = React.createClass
  render: ->
    <div className='header-bar'>
      <a className='back-to' href={@props.back_to}><Icon type='left' /></a>
      <div className='title'>{@props.title}</div>
    </div>

MobileContent = React.createClass
  render: ->
    <div className='mobile-content'>
      {@props.children}
    </div>