{ Alert, Button, Icon } = antd

module.exports = SlideShow = React.createClass
  getInitialState: ->
    key = URI(location.href).fragment()
    key = @props.slides[0].id if key == ''
    slide = @props.slides.filter((x)-> x.id == key)[0]

    slide: slide

  render: ->
    slide = @state.slide

    <div>
      <Alert message='我是演示展示组件' />
      <Alert message={slide?.name} />
      {
        if slide.mobile_demos?
          for md, idx in slide.mobile_demos
            <div key={idx}>
              <a className='ant-btn ant-btn-primary' href={md.url} target='_blank'>
                <Icon type='mobile' /> {md.name}
              </a>
            </div>
      }
    </div>
