Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 493ABB87F2
	for <lists+linux-raid@lfdr.de>; Fri, 20 Sep 2019 01:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404497AbfISXPh (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 19 Sep 2019 19:15:37 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:33446 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391244AbfISXPh (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 19 Sep 2019 19:15:37 -0400
Received: by mail-wr1-f42.google.com with SMTP id b9so4875194wrs.0
        for <linux-raid@vger.kernel.org>; Thu, 19 Sep 2019 16:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jl05G/8bQOrX8oY9UpQh1EHP2W6hBHXddOWvgJz9LTk=;
        b=kCwpMofxGzIf+nwvpCnVoV+0Brp60JvfhA7DjqUqDsgttddwbD8h/jTbW9ok44N8M2
         xQ9+TI4SFlmeKx2GQ2sFbNoAcK3hEGtEaA/97AeiZti+FOYnRftghbOwNUmZUNpH42Go
         qpVubIRTVSQuSZmtt8DFt73kSgZWOHZWp69wbfWrr5iFleGPR+EWh0NTCA927SI5QvAj
         /bv7uILTBNhbM76gYvwSmfcAL0gy4r/2SOGGftKLhQ+pqtba3+Lcenb0whBXRcAwbwju
         T7HNcTIavu3MK2KbVW1u+mYPtQ67O7vrvFPTHAIAVXTiCE3XEVq+kpB5qLV2dLQ6+A0g
         gGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jl05G/8bQOrX8oY9UpQh1EHP2W6hBHXddOWvgJz9LTk=;
        b=tL0o38BGABYIq8rRETewJyRSLQEM4k+dOCtAoK5KZXi+glhbfYs0uOBmK8+J20T4vm
         4GYpalBB+hXnBy/tuEzqAwDdTLuwWZ2bhfyySOvh1H8qJoq9oubqEKtgKnKm0/Y0MRk2
         nBpp7U43Ay38qcH6i1CnKVXlew+Cz5xc3YXuE5t46FQChCodi/F4PwSQeR/0Rnv88KkQ
         eMJH9TBg9R9CFp3DmrvrQ8rfraBliDWPclr2Zf/azi+/6F8SE5zfjS/u4ihHRwEH+6gZ
         iBQ+U0IXxwiGL66+BVlKvfdFsfXPJ+R4jt1bUYP5Qmj3yoJiwa2jH4Xv66n/oDQcf7Qs
         pefw==
X-Gm-Message-State: APjAAAXAbtPZhAhuqVhzp+ByPuULE6htOnV47bDuvOitLJmyLPx6jOvE
        h/8Y83g1z1jkS50nJ9a4TAPnVZIr1uWiliWI4VoY+A==
X-Google-Smtp-Source: APXvYqy3Ztxcb4YB+VvSG1PmlHcufbKw+LHHhNOAz5w7H/nfA070VMt8Nko7lSOGSvPty3I2yjmc9rB3Xw2KxyxWQrI=
X-Received: by 2002:adf:cc0a:: with SMTP id x10mr8814937wrh.195.1568934935274;
 Thu, 19 Sep 2019 16:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAGRSmLvhPOw+KO7yAenXqyLDq__=vSLHMHQJ5f_0iOJ5E5b=Mg@mail.gmail.com>
 <3100213.Shkhs8viAj@mtkaczyk-devel.igk.intel.com> <CAGRSmLt6xsNXsXV0YoHihe2g8N5+w0jN2p7gmGSokrY8owsQ7Q@mail.gmail.com>
 <1d098e10-a2f9-12e4-5b8c-1312f6612eaa@intel.com>
In-Reply-To: <1d098e10-a2f9-12e4-5b8c-1312f6612eaa@intel.com>
From:   "David F." <df7729@gmail.com>
Date:   Thu, 19 Sep 2019 16:15:23 -0700
Message-ID: <CAGRSmLv-RGoWr5LF8U6SrTh3m1=Wpg7F-xYYaVBCVqZFbpigDw@mail.gmail.com>
Subject: Re: Linux RAID 1 Not Working
To:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Cc:     "Tkaczyk, Mariusz" <mariusz.tkaczyk@intel.com>,
        Linux-RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

that was the issue.

thanks.

On Mon, Sep 16, 2019 at 12:12 AM Artur Paszkiewicz
<artur.paszkiewicz@intel.com> wrote:
>
> On 9/16/19 1:30 AM, David F. wrote:
> > Now I have a question, if mdadm is reading from UEFI, is it needing
> > the efivarfs mounted?  because it's not mounted by defau
>
> That's right, efivars is required.
>
> Regards,
> Artur
