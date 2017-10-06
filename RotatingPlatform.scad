module grating(length=72,width=36,bar_h=1.5,bar_w=4./16,bar_dw=19./16,cbar_dw=4,orient=[0,0,0]){
    Nbars=floor(width/bar_dw);
    Ncbar=floor(length/cbar_dw);
    rotate(orient){
        union(){
            for(i=[1:Nbars]){
                translate([-length/2,bar_dw*(i-.5-Nbars/2),-bar_h/2]){
                    cube([length,bar_w,bar_h]);
                }
            }
            for(j=[1:Ncbar]){
                translate([(j-.5-Ncbar/2)*cbar_dw,-width/2,-bar_w/2]){
                    cube([bar_w,width,bar_w]);
                }
            }
        }
    }
}

module turntable(height=2.88,diameter=8.5,thickness=.5){
    r=(height-3*thickness)/2;
    R=diameter/2 -1.5*thickness-r;
    for(i=[0:30:330]){
        translate([R*cos(i),R*sin(i),height/2]){
            sphere(r=r);
        };
    };
    difference(){
    union(){
        translate([0,0,thickness]){
            difference(){
                cylinder(h=height/2,d=diameter);
                cylinder(h=height/2,d2=diameter-2*thickness,d1=diameter-2*r);
            };
        };
        translate([0,0,height/2]){
            cylinder(h=height/2,d1=diameter-6*r-2*thickness,d2=diameter-2*thickness-3*r);
        };
        linear_extrude(height=thickness){
            polygon([[-diameter/2,-diameter/2],
                [+diameter/2,-diameter/2],
                [+diameter/2,+diameter/2],
                [-diameter/2,+diameter/2]]);
        };
        translate([0,0,height-thickness]){
            linear_extrude(height=thickness){
                polygon([[-diameter/2,-diameter/2],
                    [+diameter/2,-diameter/2],
                    [+diameter/2,+diameter/2],
                    [-diameter/2,+diameter/2]]);
            };
        };
    };
    union(){
        translate([-3.5,-3.5,-height/2]){cylinder(h=2*height,d=.69);};
        translate([-3.5,+3.5,-height/2]){cylinder(h=2*height,d=.69);};
        translate([+3.5,-3.5,-height/2]){cylinder(h=2*height,d=.69);};
        translate([+3.5,+3.5,-height/2]){cylinder(h=2*height,d=.69);};
    };
    };
};
module ustrut_cross_section(width=1+5./8,height=1+5./8,thickness=.1,inwidth=7./8){
        translate([-height/2,-width/2]){
    polygon([
            [height,0],
            [0,0],
            [0,width],
            [height,width],
            [height,width/2+inwidth/2],
            [height-thickness,width/2+inwidth/2],
            [height-thickness,width-thickness],
            [thickness,width-thickness],
            [thickness,+thickness],
            [height-thickness,+thickness],
            [height-thickness,width/2-inwidth/2],
            [height,width/2-inwidth/2]]);
            };
            };

module arcstrut(radius=36,width=1+5./8,height=1+5./8,thickness=.1,inwidth=7./8,face=[0,0,90],orient=[0,0,0]){
    rotate(orient){
        rotate_extrude(convexity=10){
            translate([radius+(width+height)/4,0,0]){
                rotate(face){
                    ustrut_cross_section(width=width,height=height,thickness=thickness,inwidth=inwidth);
                }
            }
        }
    }
}


module ustrut(length=60,width=1+5./8,height=1+5./8,thickness=.1,inwidth=7./8,orient=[0,0,0]){
    rotate(orient){
        translate([0,0,-length/2]){
            linear_extrude(height=length){
                ustrut_cross_section(width=width,height=height,thickness=thickness,inwidth=inwidth);
            }
        }
    }
}
$fs=2;
$fa=3;
//$fn=64;
turntable();
translate([0,0,2.88]){
    orient1=[0,-90,90];
    translate([0,0,(3.25)/2]){
        translate([+3.5,-0,0]){ustrut(height=3.25,orient=orient1);}
        translate([-3.5,+0,0]){ustrut(height=3.25,orient=orient1);}
    }
    translate([0,0,3.25]){
            translate([0,0,13/16]){
                orient2=[90,-90,90];
                ustrut(length=72,orient=orient2);
                
                translate([0,+3.5,0]){ustrut(length=60,orient=orient2);}
                translate([0,-3.5,0]){ustrut(length=60,orient=orient2);}
                
                translate([0,+9,0]){ustrut(length=60,orient=orient2);}
                translate([0,-9,0]){ustrut(length=60,orient=orient2);}

                translate([0,+17,0]){ustrut(length=60,orient=orient2);}
                translate([0,-17,0]){ustrut(length=60,orient=orient2);}
                
                translate([0,+23,0]){ustrut(length=48,orient=orient2);}
                translate([0,-23,0]){ustrut(length=48,orient=orient2);}

                translate([0,+29,0]){ustrut(length=36,orient=orient2);}
                translate([0,-29,0]){ustrut(length=36,orient=orient2);}

                arcstrut(radius=36);
                }
                translate([0,0,13/8]){
                           archieght=48;
                    translate([0,0,archieght/2]){
                        rotate([0,0,45]){
                                translate([-36-13/16,0,0]){ustrut(length=archieght);}
                                translate([+36+13/16,0,0]){ustrut(length=archieght,orient=[0,0,180]);}
                                translate([0,0,archieght/2]){
                                    difference(){
                                        arcstrut(face=[0,0,180],orient=[90,0,0]);
                                        translate([0,0,-38]){cube(size=76,center=true);}
                                        }
                                    }
                                        
                            }                        
                            rotate([0,0,-45]){
                                translate([-36-13/16,0,0]){ustrut(length=archieght);}
                                translate([+36+13/16,0,0]){ustrut(length=archieght,orient=[0,0,180]);}
                                translate([0,0,archieght/2]){
                                    difference(){
                                        arcstrut(face=[0,0,180],orient=[90,0,0]);
                                        translate([0,0,-38]){cube(size=76,center=true);}
                                        }
                                    }
                            }
                        }
                    translate([0,0,+1.5/2]){
                        grating(orient=[0,0,90],width=36);
                        translate([+24,0,0]){grating(orient=[0,0,90],length=48,width=12);}
                        translate([-24,0,0]){grating(orient=[0,0,90],length=48,width=12);}
                    }
                    translate([0,0,1.5]){

                    }
                }
        }
        }



//ustrut_cross_section();
