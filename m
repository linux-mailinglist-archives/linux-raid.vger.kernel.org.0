Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01C285C43E
	for <lists+linux-raid@lfdr.de>; Mon,  1 Jul 2019 22:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfGAUTJ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 1 Jul 2019 16:19:09 -0400
Received: from li1843-175.members.linode.com ([172.104.24.175]:36810 "EHLO
        mail.stoffel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfGAUTI (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 1 Jul 2019 16:19:08 -0400
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Jul 2019 16:19:08 EDT
Received: from quad.stoffel.org (66-189-75-104.dhcp.oxfr.ma.charter.com [66.189.75.104])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.stoffel.org (Postfix) with ESMTPSA id D4E401EF39;
        Mon,  1 Jul 2019 16:09:35 -0400 (EDT)
Received: by quad.stoffel.org (Postfix, from userid 1000)
        id 6C5A8A58D4; Mon,  1 Jul 2019 16:09:35 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <23834.26751.380798.383341@quad.stoffel.home>
Date:   Mon, 1 Jul 2019 16:09:35 -0400
From:   "John Stoffel" <john@stoffel.org>
To:     Mariusz Dabrowski <mariusz.dabrowski@intel.com>
Cc:     jes.sorensen@gmail.com, linux-raid@vger.kernel.org,
        Krzysztof Smolinski <krzysztof.smolinski@intel.com>
Subject: Re: [PATCH] mdadm: load default sysfs attributes after assemblation
In-Reply-To: <20190626075006.4815-1-mariusz.dabrowski@intel.com>
References: <20190626075006.4815-1-mariusz.dabrowski@intel.com>
X-Mailer: VM 8.2.0b under 24.5.1 (x86_64-pc-linux-gnu)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

>>>>> "Mariusz" == Mariusz Dabrowski <mariusz.dabrowski@intel.com> writes:

Mariusz> Added new type of line to mdadm.conf which allows to specify
Mariusz> values of sysfs attributes for MD devices that should be
Mariusz> loaded after assemblation.  Each line is interpreted as list
Mariusz> of structures containing sysname of MD device (md126 etc.)
Mariusz> and list of sysfs attributes and their values.

So what does this buy us?  Looking at your example, you hard code
devices to a raid name, but also include a UUID setting.  Don't you
think that's a bad idea?  


 
Mariusz> +.TP
Mariusz> +.B SYSFS
Mariusz> +The SYSFS line lists custom values of MD device's sysfs attributes which will be
Mariusz> +stored in sysfs after assemblation. Multiple lines are allowed and each line has

This should be "after assembly." Or maybe "after the array is
assembled." instead.  

Mariusz> +to contain uuid or name of the device to which it relates.

... "contain the uuid" ...

Mariusz> +.RS 4
Mariusz> +.TP
Mariusz> +.B uuid=
Mariusz> +hexadecimal identifier of MD device. This must match the uuid stored in the
Mariusz> +superblock.
Mariusz> +.TP
Mariusz> +.B name=
Mariusz> +name of the MD device as was given to
Mariusz> +.I mdadm
Mariusz> +when the array was created. It will be ignored if
Mariusz> +.B uuid
Mariusz> +is not empty.
Mariusz> +.TP
Mariusz> +.RS 7
Mariusz> +
Mariusz>  .SH EXAMPLE
Mariusz>  DEVICE /dev/sd[bcdjkl]1
Mariusz>  .br
Mariusz> @@ -657,6 +677,11 @@ CREATE group=system mode=0640 auto=part\-8
Mariusz>  HOMEHOST <system>
Mariusz>  .br
Mariusz>  AUTO +1.x homehost \-all
Mariusz> +.br
Mariusz> +SYSFS name=/dev/md/raid5 group_thread_cnt=4 sync_speed_max=1000000
Mariusz> +.br
Mariusz> +SYSFS uuid=bead5eb6:31c17a27:da120ba2:7dfda40d group_thread_cnt=4
Mariusz> +sync_speed_max=1000000

So according to the docs above, since you have a SYSFS uuid=... entry,
won't the name be ignored?

Also, it's not clear if the case of these SYSFS atttribures matters or
not.  I'd *hope* they don't, because I can see people putting in

 "SYSFS UUID=... "

Just like the regular ARRAY /dev/md3 UUID=... stuff in mdadm.conf
already.

Cheers,
John


