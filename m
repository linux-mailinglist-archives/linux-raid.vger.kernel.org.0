Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0782114A45
	for <lists+linux-raid@lfdr.de>; Mon,  6 May 2019 14:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbfEFMyL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-raid@lfdr.de>); Mon, 6 May 2019 08:54:11 -0400
Received: from p3plsmtpa08-01.prod.phx3.secureserver.net ([173.201.193.102]:53114
        "EHLO p3plsmtpa08-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725852AbfEFMyL (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 6 May 2019 08:54:11 -0400
Received: from localhost ([181.120.156.54])
        by :SMTPAUTH: with ESMTPA
        id Nd8DhQjaHoPaaNd8EhQ1vF; Mon, 06 May 2019 05:54:11 -0700
Date:   Mon, 6 May 2019 08:54:01 -0400
From:   "Renaud (Ron) OLGIATI" <renaud@olgiati-in-paraguay.org>
To:     Linux Raid <linux-raid@vger.kernel.org>
Subject: Re: Raid1 syncing every Sunday morning.
Message-ID: <20190506085401.4deac022@olgiati-in-paraguay.org>
In-Reply-To: <25aa55d2-9f7e-97d0-c49d-b4f4699fd2c4@grumpydevil.homelinux.org>
References: <20190505173439.1ba86d9d@olgiati-in-paraguay.org>
        <25aa55d2-9f7e-97d0-c49d-b4f4699fd2c4@grumpydevil.homelinux.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-mandriva-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-CMAE-Envelope: MS4wfI3dDt9I2jmJe77Jy6SwcDellBnVCpg4uW5NtIGPAPY2KDMRAgnBPqk1xGDl/PxLm2RsFjeIA3t78PtfTdjBXKl+FW3pMDIoQx355+SrwhaXcQjIuGEk
 QNedpSOMoG9XM/29izDQCH/AAQgKV4KXm3wtSoMMvaNTTvL9VEOpzQUBpyCKxlSH48HZ1JH/4f/DaA==
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Sun, 5 May 2019 23:55:10 +0200
Rudy Zijlstra <rudy@grumpydevil.homelinux.org> wrote:

> > It has come to my notice that for the last five Sundays, when I logged-in on my computer in the morning, I find rhe Raid1 arrays re-syncing. mornings, I
> >  I have checked (crontab -l) both the root and user crontabs, nothing there that is planned for Sundays.

> Which distribution?

PCLinuxOS, using XFCE as DM.
 
Cheers,
 
Ron.
-- 
                           On ne meurt qu'une fois,
                           et c'est pour longtemps.
                                        -- Molière
                                    
                   -- http://www.olgiati-in-paraguay.org --
 
