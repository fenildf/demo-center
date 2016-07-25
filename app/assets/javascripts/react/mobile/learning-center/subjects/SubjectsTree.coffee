{ Icon, Progress } = antd

module.exports = SubjectsTree = React.createClass
  render: ->
    subjects = @props.subjects.filter @props._filter

    <div className='subjects-tree'>
    {
      for subject in subjects
        <Subject 
          key={subject.id} 
          subject={subject} 
          _filter={@props._filter}
        />
    }
    </div>


Subject = React.createClass
  render: ->
    subject = @props.subject
    subjects = (subject.children || [])
    subjects = subjects.filter @props._filter
    url = "/mobile/learning-center/subjects/outline##{subject.id}"

    <div className='subject'>
      <a className='info shadow-card' href={url}>
        <Icon type='pay-circle-o' className='icc'/>
        <div className='ct'>
          <div className='title'>{subject.name}</div>
          <div className='progress'>
            <Progress percent={66} />
          </div>
        </div>
      </a>
      <SubjectChildren 
        subjects={subjects} 
        _filter={@props._filter}
        parent_component={@props.parent_component}
      />
    </div>

SubjectChildren = React.createClass
  getInitialState: ->
    collapse: true 

  render: ->
    if @props.subjects.length is 0
      <div />

    else
      classes = ClassName
        'children': true
        'collapse': @state.collapse

      action =
        <a className='action' onClick={@toggle}>
        {
          if @state.collapse
            <Icon type='right' />
          else
            <Icon type='down' />
        }
        </a>


      <div className={classes} ref='children'>
        <canvas ref='canvas' />
        {action}

        <a className='brief' onClick={@toggle}>{@props.subjects.length} 个下层知识点…</a>

        <div className='subjects'>
        {
          for subject in @props.subjects
            <Subject 
              key={subject.id} 
              subject={subject} 
              _filter={@props._filter}
              parent_component={@}
            />
        }
        </div>
      </div>

  toggle: ->
    @setState collapse: not @state.collapse

  componentDidUpdate: ->
    @draw()

  draw: ->
    if not @state.collapse
      @resize_canvas()
      @drawline()
    @props.parent_component?.draw()

  resize_canvas: ->
    canvas_dom = ReactDOM.findDOMNode @refs.canvas
    $children = jQuery ReactDOM.findDOMNode @refs.children
    
    children_height = $children.height()

    canvas_dom.height = children_height
    canvas_dom.width = 50

    jQuery(canvas_dom)
      .css
        left: -44
        top: 0

  drawline: ->
    canvas_dom = ReactDOM.findDOMNode @refs.canvas
    ctx = canvas_dom.getContext '2d'
    ctx.strokeStyle = '#ccc'
    ctx.lineWidth = 2

    $children = jQuery ReactDOM.findDOMNode @refs.children
    ctop = $children.offset().top

    $children.find('> .subjects > .subject').each (idx, subject)->
      top = jQuery(subject).offset().top - ctop
      
      ctx.beginPath()
      ctx.moveTo 15, 15
      ctx.lineTo 15, top + 9
      ctx.lineTo 21, top + 15
      ctx.lineTo 46, top + 15
      ctx.stroke()