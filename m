Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1FD14EEAF
	for <lists+linux-raid@lfdr.de>; Fri, 31 Jan 2020 15:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgAaOnu (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 31 Jan 2020 09:43:50 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54162 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728827AbgAaOnu (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Fri, 31 Jan 2020 09:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580481829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RUPc+7Xveq8JAl2vi7CsKYh/mzsroHChHddVJeJQQfs=;
        b=RGkQRxg4C1gpgV9Ryy6TfL9e+nwvtm537U3GoT6FjwRmjQ+HbR+/IBjsktM3fH0Ivojarg
        ShmlW1pEZtb7be+/3lIcEJPCrDvP/wUiAh0xnPTjXFXtGNaPmN75R//HlfZWeXF1CCYQrg
        07fRxH0+pjDt0AAtnIFGonXDbGBH1sc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-ApcONvIjMm2s7MYXN8mT7A-1; Fri, 31 Jan 2020 09:43:47 -0500
X-MC-Unique: ApcONvIjMm2s7MYXN8mT7A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6D3E800D55
        for <linux-raid@vger.kernel.org>; Fri, 31 Jan 2020 14:43:46 +0000 (UTC)
Received: from [10.10.121.2] (ovpn-121-2.rdu2.redhat.com [10.10.121.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 837DE811E3
        for <linux-raid@vger.kernel.org>; Fri, 31 Jan 2020 14:43:46 +0000 (UTC)
To:     linux-raid <linux-raid@vger.kernel.org>
From:   Nigel Croxon <ncroxon@redhat.com>
Subject: low memory deadlock with md devices and external (imsm) metadata
 handling
Message-ID: <71c1884d-a9fd-807b-86d0-4406457d605b@redhat.com>
Date:   Fri, 31 Jan 2020 09:43:45 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hello all,

I have a customer issue,=C2=A0 low memory deadlock with md devices and=20
external (imsm) metadata handling

https://bugzilla.redhat.com/show_bug.cgi?id=3D1703180

Has anyone else seen this problem?

Thanks, Nigel


