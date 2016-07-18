{ Alert } = antd

module.exports = SlideShow = React.createClass
  getInitialState: ->
    key = URI(location.href).fragment()
    key = @props.slides[0].id if key == ''
    slide = @props.slides.filter((x)-> x.id == key)[0]

    slide: slide

  render: ->
    <div>
      <Alert message='我是演示展示组件' />
      <Alert message={@state.slide?.name} />
    </div>
