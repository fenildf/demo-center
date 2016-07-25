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
      <SubjectChildren subjects={subjects} _filter={@props._filter} />
    </div>

SubjectChildren = React.createClass
  getInitialState: ->
    collapse: true 

  render: ->
    if @props.subjects.length is 0
      <div />

    else if @state.collapse
      <div className='children collapse'>
        <a className='action' onClick={@toggle}><Icon type='right' /></a>
        <a className='brief' onClick={@toggle}>{@props.subjects.length} 个下层知识点…</a>
      </div>
    else
      <div className='children' ref='children'>
        <canvas ref='canvas' />
        <a className='action' onClick={@toggle}><Icon type='down' /></a>
        {
          for subject in @props.subjects
            <Subject 
              key={subject.id} 
              subject={subject} 
              _filter={@props._filter}
            />
        }
      </div>

  toggle: ->
    @setState collapse: not @state.collapse

  componentDidUpdate: ->
    return if @state.collapse

    canvas_dom = ReactDOM.findDOMNode @refs.canvas
    $children = jQuery ReactDOM.findDOMNode @refs.children

    height = $children.height()

    canvas_dom.height = height
    canvas_dom.width = 50

    jQuery(canvas_dom)
      .css
        left: -44
        top: 0

    ctx = canvas_dom.getContext '2d'
    # ctx.strokeStyle = 'rgba(0, 0, 0, 0.3)'
    ctx.strokeStyle = '#ccc'
    ctx.lineWidth = 2

    console.log $children.find('.subject')

    ctop = $children.offset().top
    $children.find('.subject').each (idx, subject)->
      top = jQuery(subject).offset().top - ctop
      
      ctx.beginPath()
      ctx.moveTo 15, 15
      ctx.lineTo 15, top + 9
      ctx.lineTo 21, top + 15
      ctx.lineTo 46, top + 15
      ctx.stroke()