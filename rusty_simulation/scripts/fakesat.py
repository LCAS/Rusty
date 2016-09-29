#!/usr/bin/env python

import rospy

from sensor_msgs.msg import NavSatFix


class robot_pose_pub(object):
       
    
    def __init__(self, name) :
        rospy.on_shutdown(self.shutdown)
        self.rp_pub = rospy.Publisher('/stat_sat/fix', NavSatFix, latch=True, queue_size=1)
           
        self.my_timer=rospy.Timer(rospy.Duration(5), self.timer_callback)        
        rospy.loginfo("All Done ...")
        rospy.spin()


    def timer_callback(self, event):
        #print 'Timer called at ' + str(event.current_real)
        fake_msg=NavSatFix()
        fake_msg.header.frame_id='/map'
        fake_msg.latitude=53.227417
        fake_msg.longitude=-0.549391
        fake_msg.altitude=0.20
        fake_msg.position_covariance=[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        fake_msg.position_covariance_type=2
        self.publish(fake_msg)
 

    def publish(self, msg) :
        self.rp_pub.publish(msg)

    def shutdown(self):
        self.my_timer.shutdown()


if __name__ == '__main__':
    rospy.init_node('robot_pose_pub')
    server = robot_pose_pub(rospy.get_name())



