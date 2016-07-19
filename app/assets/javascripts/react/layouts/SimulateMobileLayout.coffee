module.exports = SimulateMobileLayout = React.createClass
  render: ->
    <div className='simulate-mobile'>
      <div className='simulate-screen'>
        <YieldComponent component={@props.content_component} />
      </div>
    </div>