imgs = [
  'http://i.teamkn.com/i/g2jbuFpK.jpg'
  'http://i.teamkn.com/i/aNXBWAPS.jpg'
  'http://i.teamkn.com/i/PKdLdAA6.jpg'
  'http://i.teamkn.com/i/WK6n86we.jpg'
  'http://i.teamkn.com/i/wgR0tayx.jpg'
  'http://i.teamkn.com/i/SIQHista.jpg'
  'http://i.teamkn.com/i/ZyzAFNGe.jpg'
  'http://i.teamkn.com/i/qkwD6hJC.jpg'
  'http://i.teamkn.com/i/HsAyFi8X.jpg'
  'http://i.teamkn.com/i/JGKIcJGU.jpg'
  'http://i.teamkn.com/i/edGYfHJj.jpg'
  'http://i.teamkn.com/i/t1ZhURsl.jpg'
  'http://i.teamkn.com/i/d4dtos2T.jpg'
  'http://i.teamkn.com/i/u6jzFrIN.jpg'
  'http://i.teamkn.com/i/XqmEcu0G.jpg'
  'http://i.teamkn.com/i/DHl1IhXc.jpg'
  'http://i.teamkn.com/i/klnKSQtW.jpg'
  'http://i.teamkn.com/i/mhN9bDrK.jpg'
  'http://i.teamkn.com/i/ic2piSzq.jpg'
  'http://i.teamkn.com/i/KpuOtCR2.jpg'
]


module.exports = MobileLearningSubjectsOutlinePPT = React.createClass
  render: ->
    <MobileLearningCenterSecondaryLayout 
      title='知识体系导航'
      back_to='/mobile/learning-center/subjects/outline#1-1-1'
    >
    {
      for img in imgs
        style =
          width: '100%'
          paddingBottom: '75%'
          backgroundColor: 'white'
          marginBottom: '1rem'
          backgroundImage: "url(#{img})"
          backgroundPosition: 'center center'
          backgroundSize: 'cover'

        <div style={style} className='shadow-card'>

        </div>
    }
    </MobileLearningCenterSecondaryLayout>